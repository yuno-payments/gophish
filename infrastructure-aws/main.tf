terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-west-2"
  profile = "931412643807_Secops"
}

resource "aws_instance" "gophish_server" {
  ami = "${lookup(var.AMI, var.AWS_REGION)}"
  instance_type = "t2.micro"

  subnet_id = "${lookup{var.subnet_pub}}"
  user_data = file("${path.module}/install.sh")

  tags = {
    Name = "gophish"
  }
}
