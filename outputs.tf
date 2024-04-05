output "web_alb_dns" {
  value = module.ec2.web_alb_dns
}

output "app_alb_dns" {
  value = module.ec2.app_alb_dns
}
