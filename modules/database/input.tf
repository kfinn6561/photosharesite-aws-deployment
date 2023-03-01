variable "database-name" {
  description = "Name of the database"
  type        = string
}

variable "bucket-reader-policy-arn" {
  description = "arn of the bcuket reader policy"
  type        = string
}

variable "deploy-support-bucket-name" {
  description="name of the deploy support bucket"
  trype=string
}