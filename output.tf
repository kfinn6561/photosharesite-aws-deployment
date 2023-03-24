output "db-password" {
  value     = module.database.db-password
  sensitive = true
}