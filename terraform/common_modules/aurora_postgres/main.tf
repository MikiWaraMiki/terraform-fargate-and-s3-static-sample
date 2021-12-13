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
  source = "../../elements/rds_cluster/"
  name = var.aurora_cluster_name
  engine = "aurora-postgresql"
  engine_version = var.engine_version
  allow_major_version_upgrade = false
  storage_encrypted = true // default is kms/rds
  master_username = "master_admin"
  // NOTE: tfstateに管理させないため初回のみ適用。作成後はSecrets Managerで管理させる
  is_create_random_password = true
  skip_final_snapshot = false
  deletion_protection = true
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window
  port = 5432
  db_subnet_group_name = module.subnet_group.id
  vpc_security_group_ids = var.rds_security_group_ids
  db_cluster_parameter_group_name = module.cluster_parameter_group.id
  db_cluster_db_instance_parameter_group_name = module.db_parameter_group.id
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  tags = var.tags
}

module "aurora_enhanced_monitoring_role" {
  count = var.is_enabled_enhanced_monitoring_role ? 1 : 0
  source = "../../elements/rds_enhanced_monitoring_role/"

  role_name = "${var.aurora_cluster_name}-monitoring-role"
  role_description = "For ${var.aurora_cluster_name}. Aurora enhanced monitoring role"

  tags = var.tags
}
module "aurora_instance" {
  source = "../../elements/rds_cluster_instance/"

  for_each = var.aurora_instance_attributes

  identifier = each.value.identifier
  cluster_identifier = module.aurora_cluster.cluster_id
  engine = "aurora-postgresql"
  engine_version = var.engine_version
  instance_class = each.value.instance_class
  db_parameter_group_name = module.db_parameter_group.id
  availability_zone = lookup(each.value, "availability_zone", "")
  preferred_maintenance_window = lookup(each.value, "preferred_maintenance_window", "thu:19:00-thu:20:00")
  auto_minor_version_upgrade = lookup(each.value, "auto_minor_version_upgrade", true)
  monitoring_interval = var.is_enabled_enhanced_monitoring_role ? lookup(each.value, "monitoring_interval", 30) : 0
  monitoring_role_arn = var.is_enabled_enhanced_monitoring_role ? module.aurora_enhanced_monitoring_role[0].role_arn : ""

  tags = var.tags
}
