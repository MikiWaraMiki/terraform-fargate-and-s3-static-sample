output "id" {
  description = "The id of subnet gruop"
  value = aws_db_subnet_group.this.id
}
output "arn" {
  description = "The arn of subnet group"
  value = aws_db_subnet_group.this.arn
}
