variable "public_subnet_1_id" {
  description = "AZ1 Public Subnet"
  type        = string
}

variable "private_subnet_1_app_id" {
  description = "AZ1 Private Subnet For App"
  type        = string
}

variable "public_subnet_2_id" {
  description = "AZ2 Public Subnet"
  type        = string
}

variable "private_subnet_2_app_id" {
  description = "AZ2 Private Subnet For App"
  type        = string
}

variable "public_sg_id" {
  description = "Public Security Group"
  type        = string
}

variable "private_sg_id" {
  description = "Private Security Group"
  type        = string
}
