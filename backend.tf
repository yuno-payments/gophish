terraform {
  backend "s3" {
    bucket         = "yuno-terraform"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
    key            = "infra-gophish/terraform.tfstate"
    profile        = "devops"
    region         = "us-west-2"
  }
}