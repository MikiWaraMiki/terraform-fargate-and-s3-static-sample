output "vpc_id" {
  description = "The ID of the VPC"
  value = module.vpc.vpc_id
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = module.vpc.vpc_arn
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "igw_id" {
  description = "The id of igw"
  value = aws_internet_gateway.this.id
}
output "igw_arn" {
  description = "The arn of igw"
  value = aws_internet_gateway.this.arn
}

output "elb_public_subnet_ids" {
  description = "The ids of ELB subnet"
  value = toset([
    for elb_subnet in module.elb_public_subnets : elb_subnet.id
  ])
}

output "elb_public_subnet_arns" {
  description = "The arns of ELB subnet"
  value = toset([
    for elb_subnet in module.elb_public_subnets : elb_subnet.arn
  ])
}

output "web_public_subnet_ids" {
  description = "The ids of ECS web server subnet"
  value = toset([
    for subnet in module.web_public_subnets : subnet.id
  ])
}

output "web_public_subnet_arns" {
  description = "The arns of ECS web server subnet subnet"
  value = toset([
    for subnet in module.web_public_subnets : subnet.arn
  ])
}

output "rds_private_subnet_ids" {
  description = "The ids of RDS subnet"
  value = toset([
    for subnet in module.rds_private_subnets : subnet.id
  ])
}

output "rds_private_subnet_arns" {
  description = "The arns of RDS subnet"
  value = toset([
    for subnet in module.rds_private_subnets : subnet.arn
  ])
}

output "elasticache_private_subnet_ids" {
  description = "The ids of Elasicache subnet"
  value = toset([
    for subnet in module.elasticache_private_subnets : subnet.id
  ])
}

output "elasticache_private_subnet_arns" {
  description = "The arns of Elasicache subnet"
  value = toset([
    for subnet in module.elasticache_private_subnets : subnet.arn
  ])
}

output "management_public_subnet_ids" {
  description = "The ids of management subnet"
  value = toset([
    for subnet in module.management_public_subnets : subnet.id
  ])
}
output "management_public_subnet_arns" {
  description = "The arns of management subnet"
  value = toset([
    for subnet in module.management_public_subnets : subnet.arn
  ])
}

output "public_elb_route_table_id" {
  description = "The id of elb subnet route table"
  value = module.public_elb_route_table.id
}
output "public_web_route_table_id" {
  description = "The id of web subnet route table"
  value = module.public_web_route_table.id
}
output "private_route_table_id" {
  description = "The id of private subnet route table"
  value = module.private_route_table.id
}
