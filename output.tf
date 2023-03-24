output "db-password" {
  value     = module.database.db-password
  sensitive = true
}

output "db-ip-address" {
  value = module.database.db-ip-address
}