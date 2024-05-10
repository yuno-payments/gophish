resource "aws_instance" "secops_phishing_tool" {
    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t2.micro"

    # VPC
    subnet_id = var.private_subnet

    # Security Group
    vpc_security_group_ids = ["${aws_security_group.secops_phishing_tool_sg.id}"]

    user_data = file("${path.module}/install.sh")

    # IAM
    iam_instance_profile = aws_iam_instance_profile.ssm_profile_secops_phishing_tool.name

    tags = {
        Name = "phishing_tool"
        Project = "secops_phishing_tool"
        Area = "secops"
    }
}
