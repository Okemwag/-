output "id" {
  value       = digitalocean_droplet.this.id
  description = "ID of the droplet"
}

output "urn" {
  value       = digitalocean_droplet.this.urn
  description = "URN of the droplet"
}

output "private_ip" {
  value = digitalocean_droplet.this.ipv4_address_private
}

output "public_ip" {
  value = digitalocean_droplet.this.ipv4_address
}

output "volume_urn" {
  value       = var.additional_disk_size == 0 ? "" : digitalocean_volume.this[0].urn
  description = "URN of the additional volume"
}