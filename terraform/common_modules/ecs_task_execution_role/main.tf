locals {
  common_tag = {
    Environment = var.environment
    ServiceName = var.service_name
  }
  tags = merge(
    local.common_tag,
    var.tags
  )
}


// IAM
data "aws_iam_policy" "ecs_task_execution_managed_policy" {
  name = "AmazonECSTaskExecutionRolePolicy"
}
// 上記のマネージドポリシーには含まれていないポリシーを追加
data "aws_iam_policy_document" "ecs_task_execution_parameter_store_policy" {
  statement {
    sid     = "StmtAllowParameterStore"
    effect  = "Allow"
    actions = ["ssm:GetParameters"]
    resources = var.ssm_parameter_store_resources
  }
  statement {
    sid     = "StmtEcsTaskAllowKmsAccess"
    effect  = "Allow"
    actions = ["kms:Decrypt"]
    resources = var.kms_parameter_store_resources
  }
}

module "ecs_task_execution_parameter_store_policy" {
  count = var.is_create_parameter_store_access_policy ? 1 : 0
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 4.3"

  name = var.parameter_store_access_policy_name
  description = "${var.environment}-${var.service_name}. SSM parameter store access policy."
  path = "/"
  policy = data.aws_iam_policy_document.ecs_task_execution_parameter_store_policy.json

  tags = local.tags
}

module "ecs_task_execution_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  create_role = true
  role_name = var.ecs_task_execution_role_name

  trusted_role_services = [
    "ecs-tasks.amazonaws.com"
  ]

  role_requires_mfa = false

  // TODO: 書き方が強引すぎるので修正したい
  custom_role_policy_arns = var.is_create_parameter_store_access_policy ? [
    data.aws_iam_policy.ecs_task_execution_managed_policy.arn,
    module.ecs_task_execution_parameter_store_policy[0].arn
  ] : [ data.aws_iam_policy.ecs_task_execution_managed_policy.arn ]

  tags = local.tags
}
