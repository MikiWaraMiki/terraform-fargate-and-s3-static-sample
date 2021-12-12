output "elb_security_group_id" {
  description = "The id of elb security group"
  value = module.common_security_group.elb_security_group_id
}

output "ecs_web_security_group_id" {
  description = "The id of ecs web security group"
  value = module.common_security_group.ecs_web_security_group_id
}
