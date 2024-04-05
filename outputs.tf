output "web_dns" {
  value       = module.ec2.web_alb_dns
  description = "Web public DNS"
}

output "app_dns" {
  value       = "app.test.com"
  description = "App private DNS"
}
