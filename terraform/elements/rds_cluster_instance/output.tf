output "id" {
  description = "The id of instnace"
  value = aws_rds_cluster_instance.this.id
}

output "arn" {
  description = "The arn of instance"
  value = aws_rds_cluster_instance.this.arn
}

output "identifier" {
  description = "The identifier of instance"
  value = aws_rds_cluster_instance.this.identifier
}
