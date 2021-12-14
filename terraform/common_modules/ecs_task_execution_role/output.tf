output "task_execution_role_name" {
  description = "The name of ecs task execution role"
  value = module.ecs_task_execution_role.iam_role_name
}
output "task_execution_role_arn" {
  description = "The arn of ecs task execution role"
  value = module.ecs_task_execution_role.iam_role_arn
}
