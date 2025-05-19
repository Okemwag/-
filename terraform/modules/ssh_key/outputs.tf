output "private_key" {
  value       = tls_private_key.this.private_key_pem
  description = "Private key in PEM format"
}

output "id" {
  value       = digitalocean_ssh_key.this.id
  description = "ID of the SSH key in DO"
}

output "name" {
  value       = digitalocean_ssh_key.this.name
  description = "Name of the SSH key in DO"
}

output "fingerprint" {
  value = digitalocean_ssh_key.this.fingerprint
}