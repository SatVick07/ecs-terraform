locals {
  project_name_prefix = "kms-uat"

  common_tags = {
    Project     = "kms"
    Environment = "non-prod"
    ManagedBy   = "Terraform"
  }
}

module "create_vpc" {
  source              = "../modules/network/vpc"
  project_name_prefix = "${local.project_name_prefix}"
  vpc_cidr            = "10.0.0.0/16"
  common_tags         = "${local.common_tags}"

  public_subnets = [{
    az = "ap-south-1a"

    cidr = "10.0.0.0/24"
  },
    {
      az = "ap-south-1b"

      cidr = "10.0.1.0/24"
    },
  ]

  app_private_subnets = [{
    az = "ap-south-1a"

    cidr = "10.0.50.0/24"
  },
    {
      az = "ap-south-1b"

      cidr = "10.0.51.0/24"
    },
  ]

  enable_dns_support   = true
  enable_dns_hostnames = true
}

module "firewall_rules" {
  source              = "../modules/network/firewall-rules"
  project_name_prefix = "${local.project_name_prefix}"
  common_tags         = "${local.common_tags}"
  vpc_cidr            = "${module.create_vpc.vpc_cidr}"
  vpc_id              = "${module.create_vpc.vpc_id}"
}
