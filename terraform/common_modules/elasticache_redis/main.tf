locals {
  common_tags = {
    Environment = var.environment
    Service = var.service_name
  }
  tags = merge(
    local.common_tags,
    var.tags
  )
}

module "subnet_group" {
  source = "../../elements/elasticache_subnet_group/"

  name = var.subnet_group_name
  description = "${var.environment}. For ${var.service_name}"
  subnet_ids = var.subnet_ids

  tags = local.tags
}

module "parameter_group" {
  source = "../../elements/elasticache_parameter_group/"

  name = var.parameter_group_name
  description = "${var.environment}. For ${var.service_name}"
  family = var.family
  parameter = var.parameter
}
