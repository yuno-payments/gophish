# Secops Phishing Tool - Gophish - Terraform repository

## Build infrastructure
```
terraform apply
```

### Get initial credentials
1. Access to the instance through SSM
2. Run the following command in the shell
```
grep -n "Please login with the username admin and the password" /var/log/syslog
```
3. Access to http://<instance-ip>:3333
