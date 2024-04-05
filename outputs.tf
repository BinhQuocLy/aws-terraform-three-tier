output "private_web_dns" {
  value       = module.ec2.web_alb_dns
  description = "Web public DNS"
}

output "public_app_dns" {
  value       = "app.test.com"
  description = "App private DNS"
}
