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

  tags = local.tags
}


// NOTE: Multi-AZ 2ノード以上起動する場合
module "replication_group" {
  source = "../../elements/elasticache_replication_group"

  replication_group_id = var.replication_group_id
  description = "${var.environment}. For ${var.service_name}"

  subnet_group_name = module.subnet_group.name
  parameter_group_name = module.parameter_group.id
  security_group_ids = var.security_group_ids

  maintenance_window = var.redis_maintenance_window

  cluster_size = var.cluster_size
  cluster_mode_enabled = true
  multi_az_enabled = true


  port = 6379
  instance_type = var.instance_type
  engine_version = var.engine_version

  at_rest_encryption_enabled = false
  transit_encryption_enabled = false
  automatic_failover_enabled = true
  availability_zones = var.availability_zones


  snapshot_window = null // snapshotが必要なデータを保持しない想定
  snapshot_retention_limit = 0

  tags = local.tags
}
