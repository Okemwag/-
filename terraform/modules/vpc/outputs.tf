output "id" {
  value       = digitalocean_vpc.this.id
  description = "ID of the VPC"
}

output "name" {
  value       = digitalocean_vpc.this.name
  description = "Name of the VPC"
}