output "web_alb_dns" {
  value = aws_lb.tf_test_alb_web.dns_name
}

output "app_alb_dns" {
  value = aws_lb.tf_test_alb_app.dns_name
}
