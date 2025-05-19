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

variable "droplet_ids" {
  type        = list(string)
  description = "IDs of Droplets to which the firewall will be attached"
}

variable "cidr_inbound_rules" {
  type = list(object({
    protocol         = string
    port_range       = string
    source_addresses = list(string)
  }))
  description = "Inbound rules with CIDR blocks for whitelisting"
  default     = []
}
variable "droplet_inbound_rules" {
  type = list(object({
    protocol           = string
    port_range         = string
    source_droplet_ids = list(string)
  }))
  description = "Inbound rules with Droplets for whitelisting"
  default     = []
}
variable "lb_inbound_rules" {
  type = list(object({
    protocol                  = string
    port_range                = string
    source_load_balancer_uids = list(string)
  }))
  description = "Inbound rules with Load Balancers for whitelisting"
  default     = []
}

variable "cidr_outbound_rules" {
  type = list(object({
    protocol              = string
    port_range            = string
    destination_addresses = list(string)
  }))
  description = "Outbound rules with CIDR blocks for whitelisting"
  default     = []
}
variable "droplet_outbound_rules" {
  type = list(object({
    protocol                = string
    port_range              = string
    destination_droplet_ids = list(string)
  }))
  description = "Outbound rules with Droplets for whitelisting"
  default     = []
}
variable "lb_outbound_rules" {
  type = list(object({
    protocol                       = string
    port_range                     = string
    destination_load_balancer_uids = list(string)
  }))
  description = "Outbound rules with Load Balancers for whitelisting"
  default     = []
}