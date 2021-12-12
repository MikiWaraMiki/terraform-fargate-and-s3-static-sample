resource "aws_security_group" "this" {
  count = var.is_create_security_group ? 1 : 0
  name = var.name
  description = var.description
  vpc_id = var.vpc_id

  tags = merge(
    { Name = var.name },
    var.tags
  )
}

resource "aws_security_group_rule" "ingress" {
  for_each = var.ingress_rules

  type = "ingress"
  security_group_id = var.is_create_security_group ? aws_security_group.this.id : var.security_group_id

  description = lookup(each.value, "description", "")
  from_port = lookup(each.value, "from_port", 0)
  to_port = lookup(each.value, "to_port", 0)
  protocol = lookup(each.value, "protocol", "-1")
  cidr_blocks = lookup(each.value, "cidr_blocks", null)
  source_security_group_id = lookup(each.value, "source_security_group_id", null)
}

resource "aws_security_group_rule" "egress" {
  for_each = var.egress_rules

  type = "egress"
  security_group_id = var.is_create_security_group ? aws_security_group.this.id : var.security_group_id

  description = lookup(each.value, "description", "")
  from_port = lookup(each.value, "from_port", 0)
  to_port = lookup(each.value, "to_port", 0)
  protocol = lookup(each.value, "protocol", "-1")
  cidr_blocks = lookup(each.value, "cidr_blocks", null)
  source_security_group_id = lookup(each.value, "source_security_group_id", null)
}
