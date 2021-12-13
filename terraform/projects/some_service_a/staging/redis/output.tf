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
