output "subnet_group_id" {
  description = "The id of subnet group"
  value = module.subnet_group.id
}
output "subnet_group_arn" {
  description = "The arn of subnet group"
  value = module.subnet_group.arn
}
