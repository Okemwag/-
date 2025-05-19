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
  eip_count   = var.private_instance ? 0 : 1
}

resource "digitalocean_droplet" "this" {
  name               = lower(local.name_prefix)
  image              = var.image
  region             = var.region
  size               = var.size
  vpc_uuid           = var.vpc_id
  private_networking = var.private_instance
  ssh_keys           = [var.ssh_key]
  resize_disk        = true

  tags = var.tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "digitalocean_volume" "this" {
  count  = var.additional_disk_size == 0 ? 0 : 1
  name   = lower("${local.name_prefix}-additional-disk")
  region = var.region
  size   = var.additional_disk_size

  lifecycle {
    prevent_destroy = true
  }
}

resource "digitalocean_volume_attachment" "this" {
  count      = var.additional_disk_size == 0 ? 0 : 1
  droplet_id = digitalocean_droplet.this.id
  volume_id  = digitalocean_volume.this[0].id

  lifecycle {
    prevent_destroy = true
  }
}