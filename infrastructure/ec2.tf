resource "aws_instance" "gophish" {
    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t2.micro"

    # VPC
    subnet_id = "${aws_subnet.prod-subnet-public-1.id}"

    # Security Group
    vpc_security_group_ids = ["${aws_security_group.gophish_sg.id}"]

    # the Public SSH key
    key_name = "${aws_key_pair.local-key.id}"

    user_data = file("${path.module}/install.sh")

    tags = {
        Name = "gophish"
    }
}

// Sends your public key to the instance
resource "aws_key_pair" "local-key" {
  key_name   = "local-key"
  public_key = file("${path.module}/aws-key-creds.pub")
}
