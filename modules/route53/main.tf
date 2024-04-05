## ==================================================================
## Private Hosted Zone
## ==================================================================
resource "aws_route53_zone" "tf_test_zone" {
  name = var.root_domain

  vpc {
    vpc_id = var.vpc_id
  }
}

# resource "aws_route53_record" "tf_test_zone_record" {
#   zone_id = aws_route53_zone.tf_test_zone.zone_id
#   name    = var.app_domain
#   type    = "CNAME"
#   ttl     = "300"
#   records = aws_route53_zone.tf_test_zone.name_servers
# }
