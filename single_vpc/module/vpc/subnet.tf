resource "aws_subnet" "pub_subnet" {
  for_each          = toset(var.availability_zones)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, index(var.availability_zones, each.key))
  availability_zone = each.key

  tags = {
    Name = "${var.prefix}-pub-subnet-${substr(each.key, -2, 2)}"
  }
}

resource "aws_subnet" "pri_subnet" {
  for_each          = toset(var.availability_zones)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, 4 + index(var.availability_zones, each.key))
  availability_zone = each.key

  tags = {
    Name = "${var.prefix}-pri-subnet-${substr(each.key, -2, 2)}"
  }

}