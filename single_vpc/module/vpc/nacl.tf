resource "aws_default_network_acl" "vpc_default_nacl" {
  default_network_acl_id = aws_vpc.vpc.default_network_acl_id

  lifecycle {
    ignore_changes = [subnet_ids]
  }
  tags = {
    Name = "${var.prefix}-vpc-default-nacl"
  }
}