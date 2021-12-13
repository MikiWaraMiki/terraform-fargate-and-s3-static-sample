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
  source = "../../../../common_modules/multi_az_elasticache_redis/"

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
  // replication group
  replication_group_id = "${var.environment}-${var.service_name}-redis"
  redis_maintenance_window = "mon:20:00-mon:21:00"
  cluster_size = 1
  instance_type = "cache.t4g.small"
  engine_version = "6.x"
  security_group_ids = [
    data.terraform_remote_state.security_group.outputs.elasticache_redis_security_group_id
  ]
  availability_zones = [
    "ap-northeast-1a",
    "ap-northeast-1c"
  ]

  environment = var.environment
  service_name = var.service_name
}
