//https://github.com/terraform-aws-modules/terraform-aws-alb
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name     = var.name
  internal = false

  load_balancer_type = "application"

  vpc_id = var.vpc_id
  subnets = var.elb_subnet_ids
  security_groups = var.elb_security_group_ids

  access_logs = var.is_enable_logging ? var.logging_setting : {}

  target_groups = var.target_group_attributes

  https_listeners = var.https_listeners
  https_listener_rules = var.https_listener_rules
  http_tcp_listeners = [
    {
      port = 80
      protocol = "HTTP"
      action_type = "redirect"
      redirect = {
        port = "443"
        protocol = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]
  tags = var.tags
}
