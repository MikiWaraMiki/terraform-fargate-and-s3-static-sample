output "subnet_group_name" {
  description = "The name of subnet group"
  value = module.subnet_group.name
}

output "parameter_group_id" {
  description = "The name of parmeter gruop"
  value = module.parameter_group.id
}
output "parameter_group_arn" {
  description = "The arn of parmeter gruop"
  value = module.parameter_group.arn
}

// replication group
output "replication_group_arn" {
  description = "The arn of replication group"
  value = module.replication_group.arn
}
output "replication_group_engine_version_actual"{
  description = "The running version of the cache engine."
  value = module.replication_group.engine_version_actual
}
output "replication_group_id" {
  description = "The id of elasticache replication group"
  value = module.replication_group.id
}
output "replication_group_primary_endpoint_address" {
  description = "(Redis only) The address of the endpoint for the primary node in the replication group, if the cluster mode is disabled."
  value = module.replication_group.primary_endpoint_address
}
output "replication_group_reader_endpoint_address" {
  description = "(Redis only) The address of the endpoint for the reader node in the replication group, if the cluster mode is disabled."
  value = module.replication_group.reader_endpoint_address
}
