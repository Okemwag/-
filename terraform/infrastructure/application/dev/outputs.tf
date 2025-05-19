resource "local_file" "ssh_private_key" {
  filename          = "./${module.ssh_key.name}.pem"
  sensitive_content = module.ssh_key.private_key
  file_permission   = "0600"
}

output "public_ip" {
  value       = digitalocean_floating_ip.this.ip_address
  description = "Public floating IP of the droplet"
}

output "database_public_hostname" {
  value       = module.database.public_hostname
  description = "Public endpoint for the database"
}

output "database_private_hostname" {
  value       = module.database.private_hostname
  description = "Private endpoint for the database"
}

output "database_port" {
  value       = module.database.port
  description = "Database port"
}

output "database_user" {
  value       = module.database.username
  description = "Admin user of the DB cluster"
}

output "database_connection_command" {
  value       = "mysql -u ${module.database.username} -h ${module.database.private_hostname} -P ${module.database.port} -p"
  description = "CLI command for mysql client; Get the password from console"
}