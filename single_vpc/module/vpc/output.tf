output "aws_availability_zones" {
  value = var.availability_zones
}

output "vpc" {
  value = {
    arn        = aws_vpc.vpc.arn,
    id         = aws_vpc.vpc.id,
    cidr_block = aws_vpc.vpc.cidr_block,
    tags_all   = aws_vpc.vpc.tags_all
  }
}

output "pub_subnet" {
  value = [
    for k in var.availability_zones : {
      az         = k,
      arn        = aws_subnet.pub_subnet[k].arn,
      id         = aws_subnet.pub_subnet[k].id,
      cidr_block = aws_subnet.pub_subnet[k].cidr_block,
      tags_all   = aws_subnet.pub_subnet[k].tags_all
    }
  ]
}

output "pri_subnet" {
  value = [
    for k in var.availability_zones : {
      az         = k,
      arn        = aws_subnet.pri_subnet[k].arn,
      id         = aws_subnet.pri_subnet[k].id,
      cidr_block = aws_subnet.pri_subnet[k].cidr_block,
      tags_all   = aws_subnet.pri_subnet[k].tags_all
    }
  ]
}

output "pub_route_table" {
  value = {
    arn      = aws_route_table.pub_rtb.arn,
    id       = aws_route_table.pub_rtb.id,
    route    = aws_route_table.pub_rtb.route,
    tags_all = aws_route_table.pub_rtb.tags_all
  }
}

output "pri_route_table" {
  value = [
    for k in var.availability_zones : {
      az       = k,
      arn      = aws_route_table.pri_rtb[k].arn,
      id       = aws_route_table.pri_rtb[k].id,
      route    = aws_route_table.pri_rtb[k].route,
      tags_all = aws_route_table.pri_rtb[k].tags_all
    }
  ]
}

output "nat" {
  value = [
    for k in var.availability_zones : {
      az         = k,
      id         = aws_nat_gateway.nat[k].id,
      public     = aws_nat_gateway.nat[k].connectivity_type,
      private_ip = aws_nat_gateway.nat[k].private_ip,
      public_ip  = aws_nat_gateway.nat[k].public_ip,
      tags_all   = aws_nat_gateway.nat[k].tags_all
    }
  ]
}

output "igw" {
  value = {
    arn      = aws_internet_gateway.igw.arn
    id       = aws_internet_gateway.igw.id
    vpc_id   = aws_internet_gateway.igw.vpc_id
    tags_all = aws_internet_gateway.igw.tags_all
  }
}