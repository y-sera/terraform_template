resource "aws_subnet" "pub_subnet" {
    count = length(var.availability_zones)
    vpc_id = aws_vpc.vpc.id
    cidr_block = cidrsubnet(var.vpc_cidr_block,8,count.index)
    availability_zone = var.availability_zones[count.index]
}

resource "aws_subnet" "pri_subnet" {
    count = length(var.availability_zones)
    vpc_id = aws_vpc.vpc.id
    cidr_block = cidrsubnet(var.vpc_cidr_block,8,4 + count.index)
    availability_zone = var.availability_zones[count.index]
}