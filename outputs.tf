output "public_web_dns" {
  value       = module.ec2.web_alb_dns
  description = "Public web DNS"
}

output "private_app_dns" {
  value       = var.app_dns
  description = "Private app DNS"
}
