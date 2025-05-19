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

variable "vpc_id" {
  type        = string
  description = "VPC in which the droplet should be created"
}

variable "private_instance" {
  type        = string
  description = "Specifies if the instance is in a private subnet or not"
}

variable "ssh_key" {
  type        = string
  description = "Name of the SSH key"
}

variable "image" {
  type        = string
  description = "Machine image"
}

variable "size" {
  type        = string
  description = "Size/class of the instance"
}

variable "additional_disk_size" {
  type        = number
  description = "Size of the additional storage volume in GB"
  default     = 0
}

variable "tags" {
  type        = list(string)
  description = "Tags to segregate resources"

  default = []
}