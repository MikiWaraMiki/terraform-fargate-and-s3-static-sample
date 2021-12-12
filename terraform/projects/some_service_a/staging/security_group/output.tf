output "elb_security_group_id" {
  description = "The id of elb security group"
  value = module.common_security_group.elb_security_group_id
}

output "ecs_web_security_group_id" {
  description = "The id of ecs web security group"
  value = module.common_security_group.ecs_web_security_group_id
}

output "ecs_batch_security_group_id" {
  description = "The id of ecs batch security group"
  value = module.common_security_group.ecs_batch_security_group_id
}


output "management_security_group_id" {
  description = "The id of management security group"
  value = module.common_security_group.management_security_group_id
}

output "rds_security_group_id" {
  description = "The id of rds security group"
  value = module.common_security_group.rds_security_group_id
}

output "elasticache_redis_security_group_id" {
  description = "The id of elasticache redis security group"
  value = module.common_security_group.elasticache_redis_security_group_id
}
