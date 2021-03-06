provider "aws" {
  region = "ap-northeast-1"
}
terraform {
  required_version = ">=1.0.0"

  backend "s3" {
    region = "ap-northeast-1"
  }
}

module "aurora_postgres" {
  source = "../../../../common_modules/aurora_postgres"

  // subnet group
  subnet_group_name = "${var.environment}-${var.service_name}-subnet"
  subnet_group_description = "For ${var.environment}."
  rds_subnet_ids = data.terraform_remote_state.network.outputs.rds_subnet_ids

  family = "aurora-postgresql13"

  // cluster parameter group
  cluster_parameter_group_name = "${var.environment}-postgres-cluster-parameter-group"
  cluster_parameter_group_description = "For ${var.environment}. Postgres13"
  cluster_parameter_list = [
    {
      name         = "shared_preload_libraries"
      value        = "pg_stat_statements,pg_hint_plan,pgaudit"
      apply_method = "pending-reboot"
    },
    {
      name = "timezone"
      value = "Asia/Tokyo"
      apply_method = "immediate"
    },
    {
      name = "log_statement"
      value = "all"
      apply_method = "immediate"
    },
    {
      name = "log_min_duration_statement"
      value = "1" // 1sec
      apply_method = "immediate"
    },
    {
      name = "log_duration"
      value = "1"
      apply_method = "immediate"
    },
    {
      name         = "lc_messages"
      value        = "C"
      apply_method = "immediate"
    },
    {
      name         = "lc_monetary"
      value        = "C"
      apply_method = "immediate"
    },
    {
      name         = "lc_numeric"
      value        = "C"
      apply_method = "immediate"
    },
    {
      name         = "lc_time"
      value        = "C"
      apply_method = "immediate"
    }
  ]

  // db parameter group
  db_parameter_group_name = "${var.environment}-postgres-cluster-parameter-group"
  db_parameter_group_description = "For ${var.environment}."
  db_parameter_list = []

  // aurora cluster
  aurora_cluster_name = "${var.environment}-${var.service_name}-postgres"
  engine_version = "13.4"
  rds_security_group_ids = [
    data.terraform_remote_state.security_group.outputs.rds_security_group_id
  ]

  // cluster instance
  is_enabled_enhanced_monitoring_role = true
  aurora_instance_attributes = {
    1: {
      identifier = "${var.environment}-${var.service_name}-1"
      instance_class = "db.t4g.medium"
      availability_zone = "ap-northeast-1a"
      auto_minor_version_upgrade = true
    }
  }
  tags = {
    Environment = var.environment
  }
}
