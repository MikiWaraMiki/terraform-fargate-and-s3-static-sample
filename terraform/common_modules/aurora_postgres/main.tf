module "subnet_group" {
  source = "../../elements/rds_subnet_group"
  name = var.subnet_group_name
  description = var.subnet_group_description
  subnet_ids = var.rds_subnet_ids

  tags = var.tags
}

module "cluster_parameter_group" {

}
