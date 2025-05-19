output "id" {
  value       = digitalocean_spaces_bucket.this.id
  description = "ID of the bucket"
}

output "urn" {
  value       = digitalocean_spaces_bucket.this.urn
  description = "URN of the bucket"
}

output "name" {
  value       = digitalocean_spaces_bucket.this.name
  description = "Name of the bucket"
}

output "domain" {
  value       = digitalocean_spaces_bucket.this.bucket_domain_name
  description = "Domain/FQDN of the bucket"
}