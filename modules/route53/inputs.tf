variable "vpc_id" {
  description = "VPC"
  type        = string
}

variable "root_domain" {
  description = "Root domain name for the general purpose of VPC"
  type        = string
}

variable "app_domain" {
  description = "App domain name for app APIs"
  type        = string
}
