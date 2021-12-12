output "elb_security_group_id" {
  description = "The id of elb security group"
  value = module.elb_security_group.security_group_id
}

output "ecs_web_security_group_id" {
  description = "The id of ecs web security group"
  value = module.ecs_web_security_group.security_group_id
}
