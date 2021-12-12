module "vpc" {
  source = "../../elements/vpc"

  name = var.vpc_name
  cidr = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  enable_ipv6 = false

  tags = var.tags
}

/**
  IGW
**/
resource "aws_internet_gateway" "this" {
  vpc_id = module.vpc.vpc_id

  tags = merge(
    var.tags,
    {
      "Name" = "igw-${var.vpc_name}"
    }
  )
}

/**
  Subnet
**/
module "elb_public_subnets" {
  source = "../../elements/subnet"
  for_each = var.elb_subnet_attributes

  vpc_id = module.vpc.vpc_id
  name = each.value.name
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = true // this is public subnet
  tags = var.tags
}

module "web_public_subnets" {
  source = "../../elements/subnet"
  for_each = var.web_subnet_attributes

  vpc_id = module.vpc.vpc_id
  name = each.value.name
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = true // this is public subnet
  tags = var.tags
}

module "rds_private_subnets" {
  source = "../../elements/subnet"
  for_each = var.rds_subnet_attributes

  vpc_id = module.vpc.vpc_id
  name = each.value.name
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = false // this is private subnet
  tags = var.tags
}

module "elasticache_private_subnets" {
  source = "../../elements/subnet"
  for_each = var.elasticache_subnet_attributes

  vpc_id = module.vpc.vpc_id
  name = each.value.name
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = false // this is private subnet
  tags = var.tags
}

module "management_public_subnets" {
  source = "../../elements/subnet"
  for_each = var.management_subnet_attributes

  vpc_id = module.vpc.vpc_id
  name = each.value.name
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = true // this is public subnet
  tags = var.tags
}

/**
  Route Table
**/
module "public_elb_route_table" {
  source = "../../elements/route_table"

  vpc_id = module.vpc.vpc_id
  name = "${var.environment}-${var.service_name}-public-rtb"
  igw_id = aws_internet_gateway.this.id
  is_public_route_table = true
  is_create_default_route = true

  tags = var.tags
}

// NOTE: private subnetに切り替えれるようにelb public subnetと分けておく
module "public_web_route_table" {
  source = "../../elements/route_table"

  vpc_id = module.vpc.vpc_id
  name = "${var.environment}-${var.service_name}-public-web-rtb"
  igw_id = aws_internet_gateway.this.id
  is_public_route_table = true
  is_create_default_route = true

  tags = var.tags
}

module "private_route_table" {
  source = "../../elements/route_table"

  vpc_id = module.vpc.vpc_id
  name = "${var.environment}-${var.service_name}-private-rtb"
  is_private_route_table = true
  is_create_default_route = false

  tags = var.tags
}

resource "aws_route_table_association" "public_elb_table" {
  for_each = toset([
    for subnet in module.elb_public_subnets : subnet.id
  ])

  subnet_id = each.value
  route_table_id = module.public_elb_route_table.id
}

resource "aws_route_table_association" "public_web_table" {
  for_each = toset(
    concat(
      [for subnet in module.web_public_subnets : subnet.id],
      [for subnet in module.management_public_subnets : subnet.id]
    )
  )
  subnet_id = each.value
  route_table_id = module.public_web_route_table.id
}

resource "aws_route_table_association" "private_rds" {
  for_each = toset(
    concat(
      [for subnet in module.rds_private_subnets : subnet.id],
      [for subnet in module.elasticache_private_subnets : subnet.id]
    )
  )
  subnet_id = each.value
  route_table_id = module.private_route_table.id
}

/**
  Network ACL
**/
locals {
  default_ingress_rule = {
    100: {
      rule_number = 100
      rule_action = "allow"
      cidr_block = "0.0.0.0/0"
      from_port = 0
      to_port = 0
      protocol = "all"
    }
  }
  default_egress_rule = {
    100: {
      rule_number = 100
      rule_action = "allow"
      cidr_block = "0.0.0.0/0"
      from_port = 0
      to_port = 0
      protocol = "all"
    }
  }

  public_ingress_rule = var.ingress_public_nacl_rules == {} ? local.default_ingress_rule : merge(
    var.ingress_public_nacl_rules,
    local.default_ingress_rule
  )
  public_egress_rule = var.egress_public_nacl_rules == {} ? local.default_egress_rule : merge(
    var.egress_public_nacl_rules,
    local.default_egress_rule
  )
  private_ingress_rule = var.ingress_private_nacl_rules == {} ? local.default_ingress_rule : merge(
    var.ingress_private_nacl_rules,
    local.default_ingress_rule
  )
  private_egress_rule = var.egress_private_nacl_rules == {} ? local.default_egress_rule : merge(
    var.egress_private_nacl_rules,
    local.default_egress_rule
  )

}
module "public_nacl" {
  source = "../../elements/network_acl"

  name = "${var.environment}-${var.service_name}-public"
  vpc_id = module.vpc.vpc_id
  subnet_ids = toset(
    concat(
      [for subnet in module.elb_public_subnets : subnet.id],
      [for subnet in module.web_public_subnets : subnet.id],
      [for subnet in module.management_public_subnets : subnet.id]
    )
  )

  ingress_rule = local.public_ingress_rule
  egress_rule = local.public_egress_rule

  tags = var.tags
}

module "private_nacl" {
  source = "../../elements/network_acl"

  name = "${var.environment}-${var.service_name}-private"
  vpc_id = module.vpc.vpc_id
  subnet_ids = toset(
    concat(
      [for subnet in module.rds_private_subnets : subnet.id],
      [for subnet in module.elasticache_private_subnets : subnet.id]
    )
  )

  ingress_rule = local.private_ingress_rule
  egress_rule = local.private_egress_rule

  tags = var.tags
}
