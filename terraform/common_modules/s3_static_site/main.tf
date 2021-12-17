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

// https://github.com/terraform-aws-modules/terraform-aws-s3-bucket
module "bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "2.11.1"
  bucket = var.bucket_name
  acl = "private"

  force_destroy = true

  versioning = {
    enabled = true
    mfa_delete = false
  }

  tags = local.tags
}

data "aws_iam_policy_document" "cf_access" {
  statement {
    effect = "Allow"
    actions = ["s3:GetObject"]
    resources = [
      "${module.bucket.s3_bucket_arn}/*"
    ]
    principals {
      type = "AWS"
      identifiers = [
        var.cf_origin_access_identity_iam_arn
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "cf_access" {
  bucket = module.bucket.s3_bucket_id
  policy = data.aws_iam_policy_document.cf_access.json
}
