output "id" {
  description = "The id of subnet."
  value = aws_subnet.this.id
}

output "arn" {
  description = "The arn of subnet."
  value = aws_subnet.this.arn
}
