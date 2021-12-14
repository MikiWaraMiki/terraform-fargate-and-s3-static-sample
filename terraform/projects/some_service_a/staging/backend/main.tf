provider "aws" {
  region = "ap-northeast-1"
}
terraform {
  required_version = ">=1.0.0"

  backend "s3" {
    region = "ap-northeast-1"
  }
}

// NOTE: ecs-serviceとecs-task-definitionはecspressonで管理するため、作成しない
// https://github.com/kayac/ecspresso
module "ecs_backend" {
  source = "../../../../common_modules/fargate_ecs_cluster"

  cluster_name = "${var.environment}-${var.service_name}-backend"
  default_capacity_provider_strategy = [
    {
      capacity_provider = "FARGATE"
      weight = "1"
      base = "1"
    },
    {
      capacity_provider = "FARGATE_SPOT"
      weight = "1"
      base = "0"
    }
  ]

  environment = var.environment
  service_name = var.service_name
}

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
    module.nestjs_log_delivery_policy.arn
  ]

  role_requires_mfa = false

  tags = {
    Environment = var.environment
    ServiceName = var.service_name
  }
}

// Log Gruop
module "nestjs_log_group" {
  source = "terraform-aws-modules/cloudwatch/aws//modules/log-group"

  name = "ecs/${var.service_name}/${var.environment}/backend"
  retention_in_days = 7

  tags = {
    Environment = var.environment
    ServiceName = var.service_name
  }
}
