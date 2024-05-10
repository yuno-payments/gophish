locals {
  account_name = terraform.workspace
  environment = var.env[local.account_name]

  common_tags = {
    account_name = local.account_name
    environment = local.environment
  }
}

provider "aws" {
  region  = var.aws_region[local.account_name]
  profile = local.account_name
}
