provider "aws" {
  region                  = "ap-south-1"
  shared_credentials_file = "/home/vicky/.aws/credentials"
  profile                 = "default"
}

terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}

data "terraform_remote_state" "static" {
  backend = "local"

  config = {
    path = "../static/terraform.tfstate"
  }
}

locals {
  project_name_prefix = "${data.terraform_remote_state.static.project_name_prefix}"
  common_tags = "${data.terraform_remote_state.static.common_tags}"
}