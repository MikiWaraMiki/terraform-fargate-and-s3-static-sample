output "vpc_id" {
  description = "The ID of the VPC"
  value = module.network.vpc_id
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = module.network.vpc_arn
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.network.vpc_cidr_block
}

output "elb_public_subnet_ids" {
  description = "The ids of ELB subnet"
  value = module.network.elb_public_subnet_ids
}

output "elb_public_subnet_arns" {
  description = "The arns of ELB subnet"
  value = module.network.elb_public_subnet_arns
}

output "ecs_web_subnet_ids" {
  description = "The ids of ECS web subnet"
  value = module.network.web_public_subnet_ids
}
output "ecs_web_subnet_arns" {
  description = "The arns of ECS web subnet"
  value = module.network.web_public_subnet_arns
}

output "rds_subnet_ids" {
  description = "The ids of RDS subnet"
  value = module.network.rds_private_subnet_ids
}
output "rds_subnet_arns" {
  description = "The arns of RDS subnet"
  value = module.network.rds_private_subnet_arns
}

output "elasticache_subnet_ids" {
  description = "The ids of Elastiacache subnet"
  value = module.network.elasticache_private_subnet_ids
}
output "elastiacache_subnet_arns" {
  description = "The arns of Elasticache subnet"
  value = module.network.elasticache_private_subnet_arns
}

output "management_subnet_ids" {
  description = "The ids of management subnet"
  value = module.network.management_public_subnet_ids
}
output "management_subnet_arns" {
  description = "The arns of management subnet"
  value = module.network.management_public_subnet_arns
}

output "public_elb_route_table_id" {
  description = "The id of elb subnet route table"
  value = module.network.public_elb_route_table_id
}
output "public_web_route_table_id" {
  description = "The id of web subnet route table"
  value = module.network.public_web_route_table_id
}
output "private_route_table_id" {
  description = "The id of private subnet route table"
  value = module.network.private_route_table_id
}

output "public_network_acl_id" {
  description = "The id of public network acl"
  value = module.network.public_network_acl_id
}
output "public_network_acl_arn" {
  description = "The arn of public network acl"
  value = module.network.public_network_acl_arn
}
