variable "subnet_pub" {
  description = "Public Subnet"
  default = "devops-public-us-west-2b"
}

variable "AWS_REGION" {    
    default = "us-east-2"
}

variable "AMI" {
    type = map

    default = {
        us-east-2 = "ami-0430580de6244e02e"
    }
}
