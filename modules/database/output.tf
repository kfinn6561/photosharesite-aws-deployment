output "ssh-private-key" {
  value     = module.ssh_key.private_key
  sensitive = true
}

output "db-password" {
  value     = random_password.db-root-password
  sensitive = true
}