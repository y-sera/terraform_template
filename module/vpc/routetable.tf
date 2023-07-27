resource "aws_route_table" "pub_rtb" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "pri_rtb" {
  for_each = toset(var.availability_zones)
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "pub_route" {
  route_table_id = aws_route_table.pub_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route" "pri_route" {
  for_each = toset(var.availability_zones)
  route_table_id = aws_route_table.pri_rtb[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat[each.key].id
}

resource "aws_route_table_association" "pub_rtb_association" {
  for_each = toset(var.availability_zones)
  subnet_id = aws_subnet.pub_subnet[each.key].id
  route_table_id = aws_route_table.pub_rtb.id
}

resource "aws_route_table_association" "pri_rtb_association" {
  for_each = toset(var.availability_zones)
  subnet_id = aws_subnet.pri_subnet[each.key].id
  route_table_id = aws_route_table.pri_rtb[each.key].id
}