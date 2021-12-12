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
  subnet_id = [
    for subnet in module.elb_public_subnets : subnet.id
  ]
  route_table_id = module.public_elb_route_table.id
}

resource "aws_route_table_association" "public_web_table" {
  subnet_id = [
    for subnet in module.web_public_subnets : subnet.id
  ]
  route_table_id = module.public_web_route_table.id
}


resource "aws_route_table_association" "private_table" {
  subnet_id = concat(
    [
      for subnet in module.rds_private_subnets : subnet.id
    ],
    [
      for subnet in module.elasticache_private_subnets: subnet.id
    ]
  )
  route_table_id = module.private_route_table.id
}
