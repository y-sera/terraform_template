resource "aws_nat_gateway" "nat" {
  count = length(var.availability_zones)

  allocation_id = aws_eip.eip[count.index].id
  subnet_id = aws_subnet.pub_subnet[count.index].id
}

resource "aws_eip" "eip" {
  count = length(var.availability_zones)
}