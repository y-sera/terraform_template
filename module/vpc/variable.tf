variable vpc_cidr_block {}
variable prefix {}
variable availability_zones { 
    type = list(string)
    default = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
}

variable "flowlog_retention_days" {
  type    = number
  default = 3
}

variable "flowlog_type" {
  type    = string
  default = "ALL"
}

locals {
  account_id = data.aws_caller_identity.aws.account_id
}