resource "aws_nat_gateway" "nat" {
  for_each = toset(var.availability_zones)

  allocation_id = aws_eip.eip[each.key].id
  subnet_id     = aws_subnet.pub_subnet[each.key].id

  tags = {
    Name = "${var.prefix}-nat-${substr(each.key, -2, 2)}"
  }
}

resource "aws_eip" "eip" {
  for_each = toset(var.availability_zones)
  tags = {
    Name = "${var.prefix}-nat-eip-${substr(each.key, -2, 2)}"
  }
}