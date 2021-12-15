output "firehose_log_delivery_policy" {
  description = "S3にログ配信するためのFirehose用Policy"
  value = module.firehose_put_iam_policy
}
output "firehose_log_delivery_role" {
  description = "S3にログ配信するためのFirehose用ロール"
  value = module.firehose_put_iam_role
}

output "ecs_exec_policy" {
  description = "ECS Exec用のFargate Taskに紐付けるポリシー"
  value = module.ecs_exec_policy
}
