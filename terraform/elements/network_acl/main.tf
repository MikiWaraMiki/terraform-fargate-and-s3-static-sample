resource "aws_network_acl" "this" {
  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids

  tags = merge(
    var.tags,
    {
      Name = var.name
    }
  )
}

resource "aws_network_acl_rule" "ingress" {
  for_each = var.ingress_rule

  egress = false
  network_acl_id = aws_network_acl.this.id
  rule_number = each.value["rule_number"]
  rule_action = each.value["rule_action"]
  from_port = lookup(each.value, "from_port", null)
  to_port = lookup(each.value, "to_port", null)
  icmp_code = lookup(each.value, "icmp_code", null)
  icmp_type = lookup(each.value, "icmp_type", null)
  protocol = each.value["protocol"]
  cidr_block = lookup(each.value, "cidr_block", null)
}

resource "aws_network_acl_rule" "egress" {
  for_each = var.ingress_rule

  egress = true
  network_acl_id = aws_network_acl.this.id
  rule_number = each.value["rule_number"]
  rule_action = each.value["rule_action"]
  from_port = lookup(each.value, "from_port", null)
  to_port = lookup(each.value, "to_port", null)
  icmp_code = lookup(each.value, "icmp_code", null)
  icmp_type = lookup(each.value, "icmp_type", null)
  protocol = each.value["protocol"]
  cidr_block = lookup(each.value, "cidr_block", null)
}
