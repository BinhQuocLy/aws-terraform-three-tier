output "web_dns" {
  value = module.ec2.web_alb_dns
  description = "Web public DNS"
}

output "app_dns" {
  value = module.ec2.app_alb_dns
  description = "App private DNS"
}
