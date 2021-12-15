
// ECS BackendとBatchで共通利用するIAMを作成する
// AccountID取得用
data "aws_caller_identity" "self" {}

module "ecs_task_execution_role" {
  source = "../../../../common_modules/ecs_task_execution_role/"

  is_create_parameter_store_access_policy = true
  ssm_parameter_store_resources = [
    "arn:aws:ssm:ap-northeast-1:${data.aws_caller_identity.self.account_id}:parameter/${var.service_name}/${var.environment}/*",
    "arn:aws:ssm:ap-northeast-1:${data.aws_caller_identity.self.account_id}:parameter/${var.service_name}/shared/*",
  ]
  kms_parameter_store_resources = [
    "arn:aws:kms:ap-northeast-1:${data.aws_caller_identity.self.account_id}:key/alias/aws/ssm"
  ]
  parameter_store_access_policy_name = "${var.environment}-${var.service_name}-web-parameter-store-access-policy"

  ecs_task_execution_role_name = "${var.environment}-${var.service_name}-web-task-execution-role"

  service_name = var.service_name
  environment = var.environment
}

// nestjsコンテナに割り当てるIAM
module "nestjs_log_delivery_policy" {
  source = "../../../../common_modules/ecs_log_delivery_policy/"

  policy_name = "${var.environment}-${var.service_name}-web-log-delivery"

  service_name = var.service_name
  environment = var.environment
}

// TODO: 必要なポリシーを埋める
/**
data "aws_iam_policy_document" "nestjs_policy" {

}
*/

module "nestjs_task_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  create_role = true
  role_name = "${var.environment}-${var.service_name}-backend"

  trusted_role_services = [
    "ecs-tasks.amazonaws.com"
  ]

  custom_role_policy_arns = [
    module.nestjs_log_delivery_policy.arn,
    data.terraform_remote_state.iam.outputs.ecs_exec_policy.arn
  ]

  role_requires_mfa = false

  tags = {
    Environment = var.environment
    ServiceName = var.service_name
  }
}
