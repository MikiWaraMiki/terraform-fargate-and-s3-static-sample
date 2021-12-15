data "aws_iam_policy_document" "ecs_task_role_ssmmessages" {
  version = "2012-10-17"
  statement {
    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]
    resources = ["*"]
  }
}

module "ecs_exec_policy" {
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name = "${var.service_name}-fargate-ecs-exec-policy"
  path = "/"
  description = "For ${var.service_name}. Fargate ECS Exec policy"

  policy = data.aws_iam_policy_document.policy.json

  tags = {
    ServiceName = var.service_name
  }
}
