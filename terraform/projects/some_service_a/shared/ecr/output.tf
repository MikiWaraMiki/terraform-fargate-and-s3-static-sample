output "nginx_ecr_arn" {
  description = "The arn of nginx repository"
  value = module.nginx.arn
}
output "nginx_registry_id" {
  description = "The id of nginx repository"
  value = module.nginx.registry_id
}
output "nginx_repository_url" {
  description = "The url of nginx repository"
  value = module.nginx.repository_url
}

output "nestjs_ecr_arn" {
  description = "The arn of nestjs repository"
  value = module.nestjs.arn
}
output "nestjs_registry_id" {
  description = "The id of nestjs repository"
  value = module.nestjs.registry_id
}
output "nestjs_repository_url" {
  description = "The url of nestjs repository"
  value = module.nestjs.repository_url
}

output "fluentbit_ecr_arn" {
  description = "The arn of fluentbit repository"
  value = module.fluentbit.arn
}
output "fluentbit_registry_id" {
  description = "The id of fluentbit repository"
  value = module.fluentbit.registry_id
}
output "fluentbit_registry_url" {
  description = "The url of fluentbit repository"
  value = module.fluentbit.repository_url
}
