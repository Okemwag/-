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

resource "digitalocean_database_firewall" "this" {
  cluster_id = var.database_cluster_id

  dynamic "rule" {
    for_each = var.allowed_ips
    content {
      type  = "ip_addr"
      value = rule.value
    }
  }

  dynamic "rule" {
    for_each = var.allowed_droplet_ids
    content {
      type  = "droplet"
      value = rule.value
    }
  }
}
