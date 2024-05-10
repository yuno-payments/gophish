locals {
     vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
     general_subnets = data.terraform_remote_state.vpc.outputs.general_subnets[*]
     vpc_cidr_block = data.terraform_remote_state.vpc.outputs.vpc_cidr_block
     public_subnets = data.terraform_remote_state.vpc.outputs.public_subnets[*]
}


 data "terraform_remote_state"  "vpc" {
     backend = "s3"
     workspace = local.account_name
     config = {
         bucket = "yuno-terraform"
         key = "network-layer/terraform.tfstate"
         region = "us-west-2"
         profile = "devops"
     }
 }