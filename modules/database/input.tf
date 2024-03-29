variable "database-name" {
  description = "Name of the database"
  type        = string
}

variable "db-username" {
  description = "Name of the user to connect to the db"
  type        = string
}

variable "bucket-reader-policy-arn" {
  description = "arn of the bcuket reader policy"
  type        = string
}

variable "deploy-support-bucket-id" {
  description = "id of the deploy support bucket"
  type        = string
}