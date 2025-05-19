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

resource "digitalocean_spaces_bucket" "this" {
  name   = lower(local.name_prefix)
  region = var.region

  dynamic "cors_rule" {
    for_each = var.cors_rules
    content {
      allowed_headers = lookup(cors_rule, "allowed_headers")
      allowed_methods = lookup(cors_rule, "allowed_methods")
      allowed_origins = lookup(cors_rule, "allowed_origins")
      max_age_seconds = lookup(cors_rule, "max_age_seconds")
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}