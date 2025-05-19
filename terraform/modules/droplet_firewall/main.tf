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

resource "digitalocean_firewall" "this" {
  name        = lower("${local.name_prefix}-firewall")
  droplet_ids = var.droplet_ids

  dynamic "inbound_rule" {
    for_each = var.cidr_inbound_rules
    content {
      protocol         = inbound_rule.value["protocol"]
      port_range       = inbound_rule.value["port_range"]
      source_addresses = inbound_rule.value["source_addresses"]
    }
  }
  dynamic "inbound_rule" {
    for_each = var.droplet_inbound_rules
    content {
      protocol           = inbound_rule.value["protocol"]
      port_range         = inbound_rule.value["port_range"]
      source_droplet_ids = inbound_rule.value["source_droplet_ids"]
    }
  }
  dynamic "inbound_rule" {
    for_each = var.lb_inbound_rules
    content {
      protocol                  = inbound_rule.value["protocol"]
      port_range                = inbound_rule.value["port_range"]
      source_load_balancer_uids = inbound_rule.value["source_load_balancer_uids"]
    }
  }

  dynamic "outbound_rule" {
    for_each = var.cidr_outbound_rules
    content {
      protocol              = outbound_rule.value["protocol"]
      port_range            = outbound_rule.value["port_range"]
      destination_addresses = outbound_rule.value["destination_addresses"]
    }
  }
  dynamic "outbound_rule" {
    for_each = var.droplet_outbound_rules
    content {
      protocol                = outbound_rule.value["protocol"]
      port_range              = outbound_rule.value["port_range"]
      destination_droplet_ids = outbound_rule.value["destination_droplet_ids"]
    }
  }
  dynamic "outbound_rule" {
    for_each = var.lb_outbound_rules
    content {
      protocol                       = outbound_rule.value["protocol"]
      port_range                     = outbound_rule.value["port_range"]
      destination_load_balancer_uids = outbound_rule.value["destination_load_balancer_uids"]
    }
  }
}
