resource "aws_instance" "secops_phishing_tool" {
    ami = var.ami[local.account_name]
    instance_type = "t2.micro"

    # VPC
    subnet_id = local.general_subnets[0]

    # Security Group
    vpc_security_group_ids = ["${aws_security_group.secops_phishing_tool_sg_instance.id}"]

    user_data = file("bootstrap/install.sh")

    # IAM
    iam_instance_profile = aws_iam_instance_profile.ssm_profile_secops_phishing_tool.name

    tags = {
        Name = "phishing_tool"
        Project = "secops_phishing_tool"
        Area = "secops"
    }
}
