resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block

    tags = {
        name = "${var.prefix}-vpc"
    }
}