output "backend-user-access-key" {
  value = aws_iam_access_key.backend-user-access-key.id
}

output "backend-user-secret-key" {
  value     = aws_iam_access_key.backend-user-access-key.secret
  sensitive = true
}