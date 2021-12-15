provider "aws" {
  region = "ap-northeast-1"
}
terraform {
  required_version = ">=1.0.0"

  backend "s3" {
    region = "ap-northeast-1"
  }
}

data "aws_acm_certificate" "issued" {
  domain   = local.backend_config.acm_domain
  statuses = ["ISSUED"]
}


module "public_alb" {
  source = "../../../../common_modules/public_alb"

  name = "${var.environment}-public-alb"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  elb_subnet_ids = data.terraform_remote_state.network.outputs.elb_public_subnet_ids
  elb_security_group_ids = [
    data.terraform_remote_state.security_group.outputs.elb_security_group_id
  ]

  is_enable_logging = true
  logging_setting = {
    enabled = true
    bucket = data.terraform_remote_state.logging.outputs.bucket_id
    prefix = "${var.service_name}/${var.environment}/${var.environment}-public-alb"
  }

  // See https://github.com/terraform-aws-modules/terraform-aws-alb#input_target_groups
  target_group_attributes = [
    {
      name = "${var.environment}-backend-tg"
      backend_protocol = "HTTP"
      backend_port = 80
      target_type = "ip"
      health_check = {
        enabled             = true
        path                = "/"
        port                = "traffic-port"
        interval            = 15
        healthy_threshold   = 3
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }
      tags = {
        Environment = var.environment
      }
    }
  ]

  https_listeners = [
    {
      port = 443
      protocol = "HTTPS"
      certificate_arn = data.aws_acm_certificate.issued.arn
      action_type = "fixed-response"
      fixed_response = {
        content_type = "text/plain"
        message_body = "page is not found"
        status_code = 404
      }
    }
  ]

  https_listener_rules = [
    {
      https_listener_index = 0
      priority = 1
      actions = [{
        type = "forward"
        target_group_index = 0
      }]
      conditions = [{
        http_headers = [{
          http_header_name = "x-pre-shared-key"
          values = [
            local.backend_config.cloudfront_elb_pre_shared_key
          ]
        }]
      }]
    }
  ]

  tags = {
    Environment = var.environment
  }
}
