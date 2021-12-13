resource "aws_rds_cluster_instance" "this" {
  identifier                            = var.identifier

  cluster_identifier                    = var.cluster_identifier
  engine                                = var.engine
  engine_version                        = var.engine_version
  instance_class                        = var.instance_class
  publicly_accessible                   = var.publicly_accessible
  db_subnet_group_name                  = var.db_subnet_group_name
  db_parameter_group_name               = var.db_parameter_group_name
  apply_immediately                     = var.apply_immediately
  monitoring_role_arn                   = var.monitoring_role_arn
  monitoring_interval                   = var.monitoring_interval
  promotion_tier                        = var.promotion_tier
  availability_zone                     = var.availability_zone
  preferred_maintenance_window          = var.preferred_maintenance_window
  auto_minor_version_upgrade            = var.auto_minor_version_upgrade
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_kms_key_id       = var.performance_insights_kms_key_id
  performance_insights_retention_period = var.performance_insights_retention_period
  copy_tags_to_snapshot                 = var.copy_tags_to_snapshot
  ca_cert_identifier                    = var.ca_cert_identifier

  timeouts {
    create = lookup(var.instance_timeouts, "create", "15m")
    update = lookup(var.instance_timeouts, "update", "15m")
    delete = lookup(var.instance_timeouts, "delete", "15m")
  }

  # TODO - not sure why this is failing and throwing type mis-match errors
  # tags = merge(var.tags, lookup(each.value, "tags", {}))
  tags = var.tags
}
