# Secops Phishing Tool - Gophish - Terraform repository

## Build infrastructure
```
terraform plan
terraform apply
```

## Get initial credentials
1. Access to the instance through SSM
2. Run the following command in the shell
```
grep -n "Please login with the username admin and the password" /var/log/syslog
```
3. Access to http://my-private-ip:3333

## Custom steps
1. Get domain
2. Create Hosted Zone in Route53
3. Configure certificate using ACM to add SSL
4. Configure AWS SES to add new domain (or use any SMTP server)
5. Add smap rules to Google Account to allow incoming messages from new domain
4. Run terraform

For more information refer to @secops at Yuno
