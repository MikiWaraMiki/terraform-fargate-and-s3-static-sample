output "ecs_cluster_id" {
  description = "ID of the ECS Cluster"
  value       = module.ecs_backend.ecs_cluster_id
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS Cluster"
  value       = module.ecs_backend.ecs_cluster_arn
}


output "task_execution_role_name" {
  description = "The name of ecs task execution role"
  value = module.ecs_task_execution_role.task_execution_role_name
}
output "task_execution_role_arn" {
  description = "The arn of ecs task execution role"
  value = module.ecs_task_execution_role.task_execution_role_arn
}

output "task_log_delivery_arn" {
  description = "The arn of policy"
  value = module.nestjs_log_delivery_policy.arn
}

output "nestjs_task_role_name" {
  description = "The name of nestjs task role"
  value = module.nestjs_task_role.iam_role_name
}

// Cloudwatch Logs
output "nestjs_log_group_arn" {
  description = "The arn of nestjs cloudwatch log group"
  value = module.nestjs_log_group.cloudwatch_log_group_arn
}
output "nestjs_log_group_name" {
  description = "The name of nestjs cloudwatch log group"
  value = module.nestjs_log_group.cloudwatch_log_group_arn
}
