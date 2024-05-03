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
  default = "vpc-03a8837850ab75d20"
}

variable "public_subnet_a" {
  default = "subnet-0f42cc5cceb22f324"
}

variable "public_subnet_b" {
  default = "subnet-0bf8e5100b3b43007"
}


variable "cert_arn" {
  type    = string
  default = "arn:aws:acm:us-west-2:931412643807:certificate/20216703-d8c4-4199-af5e-8712cd115b28"
}

variable "route53_zone_id" {
  default = "Z041038423YP6RQVREXBH"
}