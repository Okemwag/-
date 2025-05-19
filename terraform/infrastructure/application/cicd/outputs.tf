resource "local_file" "ssh_private_key" {
  filename          = "./${module.ssh_key.name}.pem"
  sensitive_content = module.ssh_key.private_key
  file_permission   = "0600"
}

output "public_ip" {
  value       = digitalocean_floating_ip.this.ip_address
  description = "Public floating IP of the droplet"
}

output "private_ip" {
  value       = module.app_droplet.private_ip
  description = "Private IP of the droplet"
}

output "jenkins_droplet_id" {
  value       = module.app_droplet.id
  description = "Droplet ID of the Jenkins server"
}