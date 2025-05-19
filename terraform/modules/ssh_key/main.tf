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

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "digitalocean_ssh_key" "this" {
  name       = lower("${local.name_prefix}-ssh-key")
  public_key = tls_private_key.this.public_key_openssh
}
