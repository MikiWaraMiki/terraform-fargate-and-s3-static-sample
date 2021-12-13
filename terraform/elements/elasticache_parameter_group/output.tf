output "id" {
  description = "The name of parameter group"
  value = aws_elasticache_parameter_group.default.id
}
output "arn" {
  description = "The arn of parameter group"
  value = aws_elasticache_parameter_group.default.arn
}
