variable "AWS_REGION" {    
  default = "us-west-2"
}

variable "AMI" {
  type = map

  default = {
    us-west-2 = "ami-0cf2b4e024cdb6960"
  }
}

variable "VPC" {
  default = "vpc-07ef115280de57552"
}

variable "public_subnet_a" {
  default = "subnet-0a53f96d5d4a4b746"
}

variable "public_subnet_b" {
  default = "subnet-07b102c36976198b4"
}

variable "public_subnet_c" {
  default = "subnet-0e6660009d01e7baf"
}

variable "private_subnet" {
  default = "subnet-0995aa899c2300010"
}

variable "cert_arn" {
  type    = string
  default = "arn:aws:acm:us-west-2:931412643807:certificate/20216703-d8c4-4199-af5e-8712cd115b28"
}

variable "route53_zone_id" {
  default = "Z041038423YP6RQVREXBH"
}