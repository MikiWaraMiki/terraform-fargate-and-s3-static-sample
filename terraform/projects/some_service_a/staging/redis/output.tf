output "subnet_group_name" {
  description = "The name of subnet group"
  value = module.elasticache_redis.subnet_group_name
}

output "parameter_group_id" {
  description = "The name of parmeter gruop"
  value = module.elasticache_redis.parameter_group_id
}
output "parameter_group_arn" {
  description = "The arn of parmeter gruop"
  value = module.elasticache_redis.parameter_group_arn
}

// replication group
output "replication_group_arn" {
  description = "The arn of replication group"
  value = module.elasticache_redis.replication_group_arn
}
output "replication_group_engine_version_actual"{
  description = "The running version of the cache engine."
  value = module.elasticache_redis.replication_group_engine_version_actual
}
output "replication_group_id" {
  description = "The id of elasticache replication group"
  value = module.elasticache_redis.replication_group_id
}
output "replication_group_primary_endpoint_address" {
  description = "(Redis only) The address of the endpoint for the primary node in the replication group, if the cluster mode is disabled."
  value = module.elasticache_redis.replication_group_primary_endpoint_address
}
output "replication_group_reader_endpoint_address" {
  description = "(Redis only) The address of the endpoint for the reader node in the replication group, if the cluster mode is disabled."
  value = module.elasticache_redis.replication_group_reader_endpoint_address
}
