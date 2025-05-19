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

variable "database_cluster_id" {
  type        = string
  description = "ID of the database cluster"
}

variable "allowed_ips" {
  type        = list(string)
  description = "IPs that are allowed to access the DB"
  default     = []
}

variable "allowed_droplet_ids" {
  type        = list(string)
  description = "Droplets that are allowed to access the DB"
  default     = []
}