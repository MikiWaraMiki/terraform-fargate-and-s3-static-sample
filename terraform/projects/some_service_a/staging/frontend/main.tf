provider "aws" {
  region = "ap-northeast-1"
}
terraform {
  required_version = ">=1.0.0"

  backend "s3" {
    region = "ap-northeast-1"
  }
}

module "frontend_nextjs_site" {
  source = "../../../../common_modules/s3_static_site/"

  service_name = var.service_name
  environment = var.environment

  bucket_name = "client1-${var.service_name}-${var.environment}"
  cf_origin_access_identity_iam_arn = data.terraform_remote_state.cdn_origin_access_identity.outputs.iam_arn
}
