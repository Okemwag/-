variable "application_name" {
  type        = string
  description = "Name of the application/product"
}

variable "environment" {
  type        = string
  description = "Environment in which the infrastructure is created"
}

variable "role" {
  type        = string
  description = "Role/purpose/intention of infrastructure"
}

variable "region" {
  type        = string
  description = "Region in which the droplet should be created"
}

variable "ip_range" {
  type        = string
  description = "CIDR block for the VPC"
}

