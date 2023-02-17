output "bucket-id" {
  value = aws_s3_bucket.bucket.id
}

output "instance-profile-name" {
  value = aws_iam_instance_profile.bucket-reader-profile.name
}