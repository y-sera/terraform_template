resource "aws_subnet" "subnet" {
    vpc_id = aws_vpc.vpc.id
}