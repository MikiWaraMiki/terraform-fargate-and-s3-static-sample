output "id" {
  description = "The id of security group"
  value = var.is_create_security_group ? aws_security_group.this[0].id : null
}
output "arn" {
  description = "The arn of security group"
  value = var.is_create_security_group ? aws_security_group.this[0].id : null
}
