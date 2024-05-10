resource "aws_security_group" "secops_phishing_tool_sg_instance" {
    vpc_id = local.vpc_id

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
        cidr_blocks = [local.vpc_cidr_block] 
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [local.vpc_cidr_block]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [local.vpc_cidr_block]
    }

    tags = {
        Name = "gophish"
        Project = "secops-gophish"
        Area = "secops"
    }
}

resource "aws_security_group" "secops_phishing_tool_sg_lb" {
    vpc_id = local.vpc_id

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
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