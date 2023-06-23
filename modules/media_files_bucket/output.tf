output "bucket-id" {
  value = aws_s3_bucket.bucket.id
}

output "bucket-reader-policy-arn" {
  value = aws_iam_policy.bucket-reader-policy.arn
}

output "bucket-writer-policy-arn" {
  value = aws_iam_policy.bucket-writer-policy.arn
}