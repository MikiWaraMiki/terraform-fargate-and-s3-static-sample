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

// https://github.com/terraform-aws-modules/terraform-aws-ecs/blob/master/main.tf
module "ecs_cluster" {
  source = "terraform-aws-modules/ecs/aws"

  name = var.cluster_name
  container_insights = true

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy = var.default_capacity_provider_strategy

  tags = local.tags
}
