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
      "${data.terraform_remote_state.logging.outputs.bucket_arn}/*",
      data.terraform_remote_state.logging.outputs.bucket_arn
    ]
  }
}
module "firehose_put_iam_policy" {
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name = "${var.service_name}-firehose-log-delivery-policy"
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
  role_name = "${var.service_name}-firehose-log-delivery-role"

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
