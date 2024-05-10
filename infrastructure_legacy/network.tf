resource "aws_security_group" "secops_phishing_tool_sg" {
    vpc_id = var.VPC

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 3333
        to_port = 3333
        protocol = "tcp"
        cidr_blocks = ["10.30.0.0/16"] # only allow VPN access
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "gophish"
        Project = "secops-gophish"
        Area = "secops"
    }
}