resource "aws_default_security_group" "default_sg" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.prefix}-vpc-default-sg"
  }
}