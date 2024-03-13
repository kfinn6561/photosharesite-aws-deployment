variable "secret_name" {
  description = "the name of the secret in secrets manager"
  type        = string
}

variable "secret_value" {
  description = "the value of the secret"
  type        = string
  sensitive   = "true"
}