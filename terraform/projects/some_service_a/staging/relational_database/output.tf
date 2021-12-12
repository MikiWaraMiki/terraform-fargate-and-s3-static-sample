output "subnet_group_id" {
  description = "The id of subnet group"
  value = module.aurora_postgres.subnet_group_id
}
output "subnet_group_arn" {
  description = "The arn of subnet group"
  value = module.aurora_postgres.subnet_group_arn
}

output "cluster_parameter_group_id" {
  description = "The id of cluster parameter group"
  value = module.aurora_postgres.cluster_parameter_group_id
}
output "cluster_parameter_group_arn" {
  description = "The arn of cluster parameter group"
  value = module.aurora_postgres.cluster_parameter_group_arn
}
