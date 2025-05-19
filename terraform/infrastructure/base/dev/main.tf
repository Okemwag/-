locals {
  name_prefix = "${var.application_name}-${var.environment}-${var.role}"
}

module "vpc" {
  source           = "../../../modules/vpc"
  application_name = var.application_name
  environment      = var.environment
  role             = var.role
  region           = var.region
  ip_range         = var.vpc_cidr_block
}