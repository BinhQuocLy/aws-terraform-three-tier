output "vpc_id" {
  description = "VPC"
  value       = aws_vpc.tf_test_vpc.id
}

output "public_subnet_1_web_id" {
  description = "AZ1 Public Subnet For Web"
  value       = aws_subnet.tf_test_public_subnet_1_web.id
}

output "private_subnet_1_app_id" {
  description = "AZ1 Private Subnet For App"
  value       = aws_subnet.tf_test_private_subnet_1_app.id
}

output "public_subnet_2_web_id" {
  description = "AZ2 Public Subnet For Web"
  value       = aws_subnet.tf_test_public_subnet_2_web.id
}

output "private_subnet_2_app_id" {
  description = "AZ2 Private Subnet For App"
  value       = aws_subnet.tf_test_private_subnet_2_app.id
}

output "public_sg_id" {
  description = "Public Security Group"
  value       = aws_security_group.tf_test_public_sg.id
}

output "private_sg_id" {
  description = "Private Security Group"
  value       = aws_security_group.tf_test_private_sg.id
}
