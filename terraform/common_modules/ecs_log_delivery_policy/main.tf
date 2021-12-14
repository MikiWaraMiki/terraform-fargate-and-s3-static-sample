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



data "aws_iam_policy_document" "backend_container_policy" {
  statement {
    effect = "Allow"
    actions = [
      "firehose:PutRecordBatch"
    ]
    // TODO: リソース限定
    resources = length(var.firehose_arns) == 0 ? ["*"] : var.firehose_arns
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:PutLogEvents",
    ]
    resources = [ "arn:aws:logs:*:*:log-group:*:*:*" ]
  }
  statement {
    effect = "Allow"
    actions = [
			"logs:CreateLogStream",
			"logs:DescribeLogStreams",
			"logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:log-group:*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup"
    ]
    resources = ["*"]
  }
}

module "iam_policy" {
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name = var.policy_name
  description = "${var.environment}-${var.service_name}. Log Delivery policy"
  path = "/"
  policy = data.aws_iam_policy_document.backend_container_policy.json

  tags = local.tags
}
