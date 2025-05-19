output "id" {
  value       = digitalocean_database_cluster.this.id
  description = "ID of the DB cluster"
}

output "urn" {
  value       = digitalocean_database_cluster.this.urn
  description = "URN of the DB cluster"
}

output "name" {
  value       = digitalocean_database_cluster.this.name
  description = "Name of the DB cluster"
}

output "public_hostname" {
  value       = digitalocean_database_cluster.this.host
  description = "Public hostname of the DB cluster"
}

output "private_hostname" {
  value       = digitalocean_database_cluster.this.private_host
  description = "Private hostname of the DB cluster"
}

output "port" {
  value       = digitalocean_database_cluster.this.port
  description = "Port...."
}

output "username" {
  value       = digitalocean_database_cluster.this.user
  description = "Default admin user of the DB cluster"
}

