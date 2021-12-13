resource "aws_elasticache_replication_group" "this" {
  auth_token                    = var.transit_encryption_enabled ? var.auth_token : null
  replication_group_id          = var.replication_group_id
  replication_group_description = var.description
  node_type                     = var.instance_type
  number_cache_clusters         = var.cluster_mode_enabled ? var.cluster_size : null
  port                          = var.port
  parameter_group_name          = var.parameter_group_name
  availability_zones            = var.availability_zones
  automatic_failover_enabled    = var.automatic_failover_enabled
  multi_az_enabled              = var.multi_az_enabled
  subnet_group_name             = var.subnet_group_name
  # It would be nice to remove null or duplicate security group IDs, if there are any, using `compact`,
  # but that causes problems, and having duplicates does not seem to cause problems.
  # See https://github.com/hashicorp/terraform/issues/29799
  security_group_ids         = var.security_group_ids
  maintenance_window         = var.maintenance_window
  notification_topic_arn     = var.notification_topic_arn
  engine_version             = var.engine_version
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled || var.auth_token != null
  kms_key_id                 = var.at_rest_encryption_enabled ? var.kms_key_id : null
  snapshot_name              = var.snapshot_name
  snapshot_arns              = var.snapshot_arns
  snapshot_window            = var.snapshot_window
  snapshot_retention_limit   = var.snapshot_retention_limit
  final_snapshot_identifier  = var.final_snapshot_identifier
  apply_immediately          = var.apply_immediately

  tags = var.tags

  lifecycle {
    ignore_changes = [number_cache_clusters]
  }
}
