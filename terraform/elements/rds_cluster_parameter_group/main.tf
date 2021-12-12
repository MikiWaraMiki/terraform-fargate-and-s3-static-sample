resource "aws_rds_cluster_parameter_group" "this" {
  name = var.name
  family = var.family
  description = var.description

  dynamic parameter {
    for_each = var.parameter_list

    content {
      name = lookup(parameter.value, "name", null)
      value = lookup(parameter.value, "value", null)
      apply_method = lookup(parameter.value, "apply_method", "immediate")
    }
  }

  tags = var.tags
}
