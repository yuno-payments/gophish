resource "aws_iam_role" "ssm_role_secops_phishing_tool" {
  name               = "ssm_ec2_role_gophish"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
          "Sid": "EC2PhishingToolAssumeRole",
          "Effect": "Allow",
          "Principal": {
              "Service": "ec2.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
      }
    ]
  }
  EOF

  tags = {
      Name    = "phishing_tool"
      Project = "secops_phishing_tool"
      Area    = "secops"
  }
}

resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role   = aws_iam_role.ssm_role_secops_phishing_tool.name
  policy_arn = aws_iam_policy.policy_secops_phishing_tool.arn
}

resource "aws_iam_instance_profile" "ssm_profile_secops_phishing_tool" {
  name = "ssm_ec2_role_gophish"
  role = aws_iam_role.ssm_role_secops_phishing_tool.name

  tags = {
      Name    = "phishing_tool"
      Project = "secops_phishing_tool"
      Area    = "secops"
  }
}

resource "aws_iam_policy" "policy_secops_phishing_tool" {
  name        = "secops_gophish_tool"
  path        = "/"
  description = "Policy to allow ssm on gophish tool"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:DescribeAssociation",
                "ssm:GetDeployablePatchSnapshotForInstance",
                "ssm:GetDocument",
                "ssm:DescribeDocument",
                "ssm:GetManifest",
                "ssm:GetParameter",
                "ssm:GetParameters",
                "ssm:ListAssociations",
                "ssm:ListInstanceAssociations",
                "ssm:PutInventory",
                "ssm:PutComplianceItems",
                "ssm:PutConfigurePackageResult",
                "ssm:UpdateAssociationStatus",
                "ssm:UpdateInstanceAssociationStatus",
                "ssm:UpdateInstanceInformation"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2messages:AcknowledgeMessage",
                "ec2messages:DeleteMessage",
                "ec2messages:FailMessage",
                "ec2messages:GetEndpoint",
                "ec2messages:GetMessages",
                "ec2messages:SendReply"
            ],
            "Resource": "*"
        }
    ]
  })

  tags = {
      Name    = "phishing_tool"
      Project = "secops_phishing_tool"
      Area    = "secops"
  }
}
