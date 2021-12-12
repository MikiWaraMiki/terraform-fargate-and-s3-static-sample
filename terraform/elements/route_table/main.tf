resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags,
  )
}

resource "aws_route" "default_public_ipv4_route" {
  count = var.is_public_route_table && var.is_create_default_route ? 1 : 0

  route_table_id = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = var.igw_id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "default_private_ipv4_route" {
  count = var.is_private_route_table && var.is_create_default_route ? 1 : 0

  route_table_id = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = var.nat_gateway_id

  timeouts {
    create = "5m"
  }
}
