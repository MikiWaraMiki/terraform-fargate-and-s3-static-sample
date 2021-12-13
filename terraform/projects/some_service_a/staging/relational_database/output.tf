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

output "db_parameter_group_id" {
  description = "The id of cluster parameter group"
  value = module.aurora_postgres.db_parameter_group_id
}
output "db_parameter_group_arn" {
  description = "The arn of cluster parameter group"
  value = module.aurora_postgres.db_parameter_group_arn
}

output "cluster_arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = module.aurora_postgres.cluster_arn
}

output "cluster_id" {
  description = "The RDS Cluster Identifier"
  value       = module.aurora_postgres.cluster_id
}

output "cluster_resource_id" {
  description = "The RDS Cluster Resource ID"
  value       = module.aurora_postgres.cluster_resource_id
}

output "cluster_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = module.aurora_postgres.cluster_endpoint
}

output "cluster_reader_endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value       = module.aurora_postgres.cluster_reader_endpoint
}

output "cluster_engine_version_actual" {
  description = "The running version of the cluster database"
  value       = module.aurora_postgres.cluster_engine_version_actual
}
