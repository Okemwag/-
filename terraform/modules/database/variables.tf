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

variable "engine" {
  type        = string
  description = "Database engine"
}

variable "engine_version" {
  type        = string
  description = "Version of the database engine"
}

variable "size" {
  type        = string
  description = "Size/class of the instance"
}

variable "node_count" {
  type        = number
  description = "Number of database instances"
  default     = 1

  validation {
    condition     = var.node_count > 0
    error_message = "Node Count must be 1 or greater."
  }
}

variable "tags" {
  type        = list(string)
  description = "Tags to segregate resources"
  default     = []
}