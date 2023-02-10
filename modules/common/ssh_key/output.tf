output "key_name" {
  value = var.key_name
}

output "private_key" {
  value = tls_private_key.ed25519.private_key_pem
  sensitive = "true"
}

output "public_key" {
  value = tls_private_key.ed25519.public_key_openssh
}