output "subnet_group_id" {
  description = "The id of subnet group"
  value = module.subnet_group.id
}
output "subnet_group_arn" {
  description = "The arn of subnet group"
  value = module.subnet_group.arn
}

output "cluster_parameter_group_id" {
  description = "The id of cluster parameter group"
  value = module.cluster_parameter_group.id
}
output "cluster_parameter_group_arn" {
  description = "The arn of cluster parameter group"
  value = module.cluster_parameter_group.arn
}

output "db_parameter_group_id" {
  description = "The id of cluster parameter group"
  value = module.db_parameter_group.id
}
output "db_parameter_group_arn" {
  description = "The arn of cluster parameter group"
  value = module.db_parameter_group.arn
}
