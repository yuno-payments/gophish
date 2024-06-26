resource "aws_lb" "secops_phishing_tool_lb" {
  name               = "phishing-lb-${local.account_name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.secops_phishing_tool_sg_lb.id]
  subnets = local.public_subnets

  tags = {
    Name = "gophish"
    Project = "secops-gophish"
    Area = "secops"
  }
}

resource "aws_lb_listener" "secops_phishing_tool_lb_listener_http" {
  load_balancer_arn = "${aws_lb.secops_phishing_tool_lb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = {
    Name = "gophish"
    Project = "secops-gophish"
    Area = "secops"
  }
}

resource "aws_lb_listener" "secops_phishing_tool_lb_listener_https" {
  load_balancer_arn = aws_lb.secops_phishing_tool_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn = var.cert_arn[local.account_name]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.secops_phishing_tool_lb_tg_https.arn
  }

  tags = {
    Name = "gophish"
    Project = "secops-gophish"
    Area = "secops"
  }
}

resource "aws_lb_target_group" "secops_phishing_tool_lb_tg_https" {
  name                 = "phishing-internal-https-${local.account_name}"
  port                 = 443
  protocol             = "HTTP"
  target_type          = "instance"
  ip_address_type      = "ipv4"
  vpc_id               = local.vpc_id
  health_check {
    port     = 443
    protocol = "HTTP"
    path = "/"
    matcher = 404
  }
}

resource "aws_lb_target_group_attachment" "secops_phishing_tool_internal_https" {
  target_group_arn = aws_lb_target_group.secops_phishing_tool_lb_tg_https.arn
  target_id        = aws_instance.secops_phishing_tool.id
  port             = 443
}

resource "aws_route53_record" "alias_route53_record" {
  zone_id = var.route53_zone_id[local.account_name]
  name    = "gophish"
  type    = "A"

  alias {
    name                   = aws_lb.secops_phishing_tool_lb.dns_name
    zone_id                = aws_lb.secops_phishing_tool_lb.zone_id
    evaluate_target_health = true
  }
}
