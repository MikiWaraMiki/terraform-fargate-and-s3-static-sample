output "arn" {
  description = "The arn of replication group"
  value = aws_elasticache_replication_group.this.arn
}
output "engine_version_actual"{
  description = "The running version of the cache engine."
  value = aws_elasticache_replication_group.this.engine_version_actual
}
output "id" {
  description = "The id of elasticache replication group"
  value = aws_elasticache_replication_group.this.id
}
output "primary_endpoint_address" {
  description = "(Redis only) The address of the endpoint for the primary node in the replication group, if the cluster mode is disabled."
  value = aws_elasticache_replication_group.this.primary_endpoint_address
}
output "reader_endpoint_address" {
  description = "(Redis only) The address of the endpoint for the reader node in the replication group, if the cluster mode is disabled."
  value = aws_elasticache_replication_group.this.reader_endpoint_address
}
