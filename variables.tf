variable "backend_profile" {
  type        = string
  description = "AWS profile"
  default     = "devops"
}

variable "aws_region" {
  type        = map(string)
  description = "AWS region"
  default = {
    devops                  = "us-west-2"
  }
}

variable "env" {
  type        = map(string)
  description = "environment, these will be dev,stage or prod"
  default = {
    devops                  = "prod"
  }
}

variable "ami" {
  type = map

  default = {
    devops = "ami-0cf2b4e024cdb6960"
    
  }
}

variable "cert_arn" {
  type    = map
  default = {
    devops = "arn:aws:acm:us-west-2:931412643807:certificate/20216703-d8c4-4199-af5e-8712cd115b28"
  }
}

variable "route53_zone_id" {
  type    = map
  default = {
    devops = "Z041038423YP6RQVREXBH"
  }
}