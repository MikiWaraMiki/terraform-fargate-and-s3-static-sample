module "elb_security_group" {
  source = "terraform-aws-modules/security-group/aws"
  name = "${var.environment}-${var.service_name}-elb-sg"
  description = "For ${var.environment}. ELB Security Group"
  vpc_id = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      rule = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow HTTP from somewhere"
    },
    {
      rule = "https-443-tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow HTTPS from somewhere"
    },
  ]

  egress_rules = ["all-all"]

  tags = var.tags
}

module "ecs_web_security_group" {
  source = "terraform-aws-modules/security-group/aws"
  name = "${var.environment}-${var.service_name}-ecs-web-sg"
  description = "For ${var.environment}. ECS Web Security Group"
  vpc_id = var.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule = "http-80-tcp"
      source_security_group_id = module.elb_security_group.security_group_id
      description = "Allow HTTP from ELB"
    }
  ]

  egress_rules = ["all-all"]

  tags = var.tags
}
