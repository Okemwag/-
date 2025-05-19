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

resource "digitalocean_database_cluster" "this" {
  name                 = lower("${local.name_prefix}-${var.engine}-cluster")
  engine               = var.engine
  version              = var.engine_version
  node_count           = var.node_count
  region               = var.region
  size                 = var.size
  private_network_uuid = var.vpc_id

  tags = var.tags

  lifecycle {
    prevent_destroy = true
  }
}