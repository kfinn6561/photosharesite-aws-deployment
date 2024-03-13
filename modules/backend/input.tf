variable "bucket-reader-policy-arn" {
  description = "arn of the bucket reader policy"
  type        = string
}

variable "bucket-writer-policy-arn" {
  description = "arn of the bucket writer policy"
  type        = string
}

variable "db-password-secret-reader-policy-arn" {
  description = "arn of the policy to read the db password"
  type        = string
}

variable "media-files-bucket-id" {
  description = "id of the media files bucket"
  type        = string
}