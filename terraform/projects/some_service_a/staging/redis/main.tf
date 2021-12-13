provider "aws" {
  region = "ap-northeast-1"
}
terraform {
  required_version = ">=1.0.0"

  backend "s3" {
    region = "ap-northeast-1"
  }
}

module "elasticache_redis" {
  source = "../../../../common_modules/elasticache_redis/"

  // subnet group
  subnet_group_name = "${var.environment}-${var.service_name}-redis"
  subnet_ids = data.terraform_remote_state.network.outputs.elasticache_subnet_ids
  // parameter group
  parameter_group_name = "${var.environment}-${var.service_name}-redis"
  family = "redis6.x"
  parameter = [
    {
      name = "timeout"
      value = "60" // 1min timeout
    }
  ]

  environment = var.environment
  service_name = var.service_name
}
