output "id" {
  description = "The id of parameter group"
  value = aws_db_parameter_group.this.id
}
output "arn" {
  description = "The arn of parameter group"
  value = aws_db_parameter_group.this.arn
}
