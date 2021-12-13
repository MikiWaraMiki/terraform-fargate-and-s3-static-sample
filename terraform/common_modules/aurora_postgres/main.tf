module "subnet_group" {
  source = "../../elements/rds_subnet_group"
  name = var.subnet_group_name
  description = var.subnet_group_description
  subnet_ids = var.rds_subnet_ids

  tags = var.tags
}

module "cluster_parameter_group" {
  source = "../../elements/rds_cluster_parameter_group"
  name = var.cluster_parameter_group_name
  description = var.cluster_parameter_group_description
  family = var.family
  parameter_list = var.cluster_parameter_list

  tags = var.tags
}

module "db_parameter_group" {
  source = "../../elements/rds_db_parameter_group"
  name = var.db_parameter_group_name
  description = var.db_parameter_group_description
  family = var.family
  parameter_list = var.db_parameter_list

  tags = var.tags
}

module "aurora_cluster" {
  name = var.aurora_cluster_name
  engine = var.aurora_engine
  engine_version = var.aurora_engine_version
  allow_major_version_upgrade = false
  storage_encrypted = true // default is kms/rds
  master_username = "admin"
  // NOTE: tfstateに管理させないため初回のみ適用。作成後はSecrets Managerで管理させる
  is_create_random_password = true
  skip_final_snapshot = false
  deletion_protection = true
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  port = 5432
  db_subnet_group_name = module.subnet_group.id
  vpc_security_group_ids = var.rds_security_group_ids
  snapshot_identifier = "${var.environment}-${var.service_name}-"
  db_cluster_db_instance_parameter_group_name = module.cluster_parameter_group.id
  db_instance_parameter_group_name = module.db_parameter_group.id
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  tags = var.tags
}
