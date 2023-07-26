module "vpc" {
    source = "./module/vpc"
    vpc_cidr_block = "10.0.0.0/16"
    vpc_name = "test_vpc"
}