output "db-password" {
  value     = module.database.db-password
  sensitive = true
}

output "db-ip-address" {
  value = module.database.db-ip-address
}

output "backend-access-key" {
  value = module.backend.backend-user-access-key
}

output "backend-secret-key" {
  value     = module.backend.backend-user-secret-key
  sensitive = true
}

output "media-files-bucket-name" {
  value = module.media-files-bucket.bucket-id
}