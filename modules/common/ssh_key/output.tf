output "key_name" {
  value = var.key_name
}

output "private_key" {
  value     = tls_private_key.RSA.private_key_pem
  sensitive = "true"
}

output "public_key" {
  value = tls_private_key.RSA.public_key_openssh
}