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
