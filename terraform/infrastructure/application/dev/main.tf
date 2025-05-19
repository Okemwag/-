locals {
  name_prefix = "${var.application_name}-${var.environment}-${var.role}"
}

resource "digitalocean_tag" "tags" {
  for_each = var.tags
  name     = "${each.key}:${each.value}"
}

module "ssh_key" {
  source           = "../../../modules/ssh_key"
  application_name = var.application_name
  environment      = var.environment
  role             = var.role
}

module "app_droplet" {
  depends_on = [
  module.ssh_key]
  source = "../../../modules/droplet"

  application_name = var.application_name
  environment      = var.environment
  role             = var.role
  image            = var.droplet_image
  private_instance = false
  region           = var.region
  size             = var.droplet_size
  ssh_key          = module.ssh_key.fingerprint
  vpc_id           = lookup(data.terraform_remote_state.base.outputs, "vpc_id")

  tags = [for tag in digitalocean_tag.tags : tag.id]
}

module "firewall" {
  source = "../../../modules/droplet_firewall"
  depends_on = [
  module.app_droplet]

  application_name = var.application_name
  environment      = var.environment
  role             = var.role
  droplet_ids = [
  module.app_droplet.id]

  cidr_inbound_rules = [
    {
      protocol   = "tcp"
      port_range = "22"
      source_addresses = [
        "0.0.0.0/0",
      "::/0"]
    },
    {
      protocol   = "tcp"
      port_range = "80"
      source_addresses = [
        "0.0.0.0/0",
      "::/0"]
    },
    {
      protocol   = "tcp"
      port_range = "443"
      source_addresses = [
        "0.0.0.0/0",
      "::/0"]
    }
  ]
  cidr_outbound_rules = [
    {
      protocol   = "tcp"
      port_range = "1-65535"
      destination_addresses = [
        "0.0.0.0/0",
        "::/0"
      ]
    },
    {
      protocol   = "udp"
      port_range = "1-65535"
      destination_addresses = [
        "0.0.0.0/0",
        "::/0"
      ]
    }
  ]
}

resource "digitalocean_floating_ip" "this" {
  region = var.region
}
resource "digitalocean_floating_ip_assignment" "this" {
  droplet_id = module.app_droplet.id
  ip_address = digitalocean_floating_ip.this.ip_address
}

module "database" {
  source           = "../../../modules/database"
  application_name = var.application_name
  environment      = var.environment
  role             = var.role
  region           = var.region
  engine           = "mysql"
  engine_version   = "8"
  size             = "db-s-1vcpu-1gb"
  vpc_id           = data.terraform_remote_state.base.outputs.vpc_id

  tags = [for tag in digitalocean_tag.tags : tag.id]
}

module "database_firewall" {
  depends_on = [module.database]
  source     = "../../../modules/database_firewall"

  application_name    = var.application_name
  environment         = var.environment
  role                = var.role
  database_cluster_id = module.database.id
  allowed_droplet_ids = [module.app_droplet.id, data.terraform_remote_state.cicd.outputs.jenkins_droplet_id]
}

module "secrets_bucket" {
  source           = "../../../modules/space_bucket"
  application_name = var.application_name
  environment      = var.environment
  role             = "${var.role}-secrets"
  region           = var.region
}

# Add everything to our project.
resource "digitalocean_project_resources" "this" {
  project = data.digitalocean_project.this.id
  resources = concat([
    module.database.urn,
    module.secrets_bucket.urn,
    module.app_droplet.urn,
    digitalocean_floating_ip.this.urn
  ], module.app_droplet.volume_urn == "" ? [] : [module.app_droplet.volume_urn])
}