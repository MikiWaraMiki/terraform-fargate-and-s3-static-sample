output "arn" {
  description = "The arn of repository"
  value = aws_ecr_repository.this.arn
}
output "registry_id" {
  description = "The id of resgistry"
  value = aws_ecr_repository.this.registry_id
}
output "repository_url" {
  description = "The arn of repository"
  value = aws_ecr_repository.this.repository_url
}
