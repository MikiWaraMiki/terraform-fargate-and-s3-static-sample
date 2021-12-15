provider "aws" {
  region = "us-east-1" # Cloudfront region
}
terraform {
  required_version = ">=1.0.0"

  backend "s3" {
    region = "ap-northeast-1"
  }
}

// Origin Request Policy and Cache Policy
module "cloudfront_policy" {
  source = "../../../../common_modules/cloudfront_policy/"

  environment = var.environment
  service_name = var.service_name
}

data "aws_acm_certificate" "issued" {
  domain   = local.backend_config.acm_domain
  statuses = ["ISSUED"]
}


module "distribution" {
  source = "terraform-aws-modules/cloudfront/aws"

  aliases = [
    "some-service-a.${local.backend_config.base_domain}"
  ]

  comment = "For ${var.environment}. multiple domains"
  enabled = true
  is_ipv6_enabled = false
  price_class = "PriceClass_All"
  wait_for_deployment = false
  retain_on_delete = false

  create_origin_access_identity = false

  origin = {
    elb_backend = {
      origin_id = "elb_backend"
      domain_name = "alb.${local.backend_config.base_domain}"
      custom_origin_config = {
        http_port = 80
        https_port = 443
        origin_protocol_policy = "match-viewer"
        origin_ssl_protocols = ["TLSv1.2"]
        origin_keepalive_timeout = 5 // 5sec
      }
      custom_header = [
        {
          name = "x-pre-shared-key",
          value = local.backend_config.cloudfront_elb_pre_shared_key
        }
      ]
    }
  }

  default_cache_behavior = {
    target_origin_id = "elb_backend"
    viewer_protocol_policy = "redirect-to-https"

    allowed_method = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
    cached_methods = ["HEAD", "GET"]
    compress = true

    use_forwarded_values = false
    // This is id for SecurityHeadersPolicy copied from https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-response-headers-policies.html
    response_headers_policy_id = "67f7725c-6f97-4210-82d7-5512b31e9d03"
    origin_request_policy_id = module.cloudfront_policy.origin_request_policy_id
    // This is id for CacheDiabledPolicy copied from https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html
    cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
  }

  viewer_certificate = {
    acm_certificate_arn = data.aws_acm_certificate.issued.arn
    ssl_support_method = "sni-only"
  }

  tags = {
    SeviceName = var.service_name
    Environment = var.environment
  }
}
