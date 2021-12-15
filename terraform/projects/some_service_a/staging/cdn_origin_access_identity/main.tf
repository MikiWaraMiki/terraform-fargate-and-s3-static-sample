/**
  OAIをcdnディレクトリで作成すると、load_balancerとfrontendで循環参照が発生するため別で作成しています
**/

provider "aws" {
  region = "us-east-1" # Cloudfront region
}
terraform {
  required_version = ">=1.0.0"

  backend "s3" {
    region = "ap-northeast-1"
  }
}

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "For ${var.service_name}. Environment is ${var.environment}"
}
