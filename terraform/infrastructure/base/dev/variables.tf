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

variable "vpc_cidr_block" {
  type        = string
  description = "IP cidr block for the VPC"
}

variable "region" {
  type        = string
  description = "Region in which the infrastructure should be created"
}

variable "tags" {
  type        = map(any)
  description = "AWS tags"
}