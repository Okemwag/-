terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "1.22.2"
    }
  }
}

locals {
  name_prefix = "${var.application_name}-${var.environment}-${var.role}"
}

resource "digitalocean_vpc" "this" {
  name     = lower(local.name_prefix)
  region   = var.region
  ip_range = var.ip_range
}