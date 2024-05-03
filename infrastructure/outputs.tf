output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.secops_phishing_tool.public_ip
}
