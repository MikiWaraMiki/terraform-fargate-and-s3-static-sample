provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  required_version = ">=1.0.0"

  backend "s3" {
    region = "ap-northeast-1"
  }
}

module "s3_bucket_for_logs" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "${var.service_name}-shared-logging-bucket"
  acl    = "log-delivery-write"

  # Allow deletion of non-empty bucket
  force_destroy = true

  attach_elb_log_delivery_policy = true  # Required for ALB logs
  attach_lb_log_delivery_policy  = true  # Required for ALB/NLB logs

  tags = {
    Environment = "all"
    ServiceName = var.service_name
  }
}

data "aws_iam_policy_document" "policy" {
  statement {
    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject"
    ]
    resources = [
      "${module.s3_bucket_for_logs.s3_bucket_arn}/*",
      module.s3_bucket_for_logs.s3_bucket_arn
    ]
  }
}

module "firehose_put_iam_policy" {
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name = "${var.service_name}-firehose-put-log-policy"
  path = "/"
  description = "For ${var.service_name}. Firehose PutObject Policy."

  policy = data.aws_iam_policy_document.policy.json

  tags = {
    ServiceName = var.service_name
  }
}

module "firehose_put_iam_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  create_role = true
  role_name = "${var.service_name}-firehose-put-log-role"

  custom_role_policy_arns = [
    module.firehose_put_iam_policy.arn
  ]

  trusted_role_services = [
    "firehose.amazonaws.com"
  ]

  role_requires_mfa = false

  tags = {
    ServiceName = var.service_name
  }
}
