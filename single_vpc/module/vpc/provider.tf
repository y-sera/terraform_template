provider "aws" {
  region = "ap-northeast-1"

  default_tags {
    tags = {
      managed = "terraform"
      module  = "${basename(abspath(path.module))}"
    }
  }
}