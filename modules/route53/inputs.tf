variable "vpc_id" {
  description = "VPC"
  type        = string
}

variable "root_dns" {
  description = "Root domain name for the general purpose of VPC"
  type        = string
}

variable "app_dns" {
  description = "App DNS"
  type        = string
}

variable "app_alb_dns" {
  description = "App ALB DNS"
  type        = string
}
