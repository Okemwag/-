variable "project_name" {
  type        = string
  description = "Name of the DO project"
}

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
  description = "Region in which the infrastructure should be created"
}

variable "droplet_image" {
  type        = string
  description = "Name/Slug of the machine image for the droplet"
}

variable "droplet_size" {
  type        = string
  description = "Size/type of the droplet"
}

variable "tags" {
  type        = map(any)
  description = "AWS tags"
}