output "ssh-private-key" {
  value     = module.ssh_key.private_key
  sensitive = true
}

output "db-password" {
  value     = random_password.db-user-password.result
  sensitive = true
}

output "db-ip-address" {
  value = aws_instance.db.public_ip
}