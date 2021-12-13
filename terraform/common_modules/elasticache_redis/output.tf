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
