resource "aws_elasticache_parameter_group" "default" {
  name   = var.name
  description = var.description
  family = var.family

  dynamic "parameter" {
    for_each = var.cluster_mode_enabled ? concat([{ name = "cluster-enabled", value = "yes" }], var.parameter) : var.parameter
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  tags = var.tags
}
