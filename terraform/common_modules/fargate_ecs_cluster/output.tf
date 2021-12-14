
output "ecs_cluster_id" {
  description = "ID of the ECS Cluster"
  value       = module.ecs_cluster.ecs_cluster_id
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS Cluster"
  value       = module.ecs_cluster.ecs_cluster_arn
}
