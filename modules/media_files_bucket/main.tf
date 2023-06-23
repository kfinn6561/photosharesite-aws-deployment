resource "random_string" "bucket_ending" {
  length    = 4
  min_lower = 4
}

resource "aws_s3_bucket" "bucket" {
  bucket        = "kieran-finn-pss-media-files-${random_string.bucket_ending.result}"
  force_destroy = true

  tags = {
    Name = "pss-media-files"
  }
}

resource "aws_iam_policy" "bucket-reader-policy" {
  name        = "media_files_bucket_reader_policy"
  description = "policy allowing reading of the media files bucket"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:Get*",
          "s3:List*"
        ]
        Resource = [
          aws_s3_bucket.bucket.arn,
          "${aws_s3_bucket.bucket.arn}/*"
        ]
      },
    ]
  })
}

resource "aws_iam_policy" "bucket-writer-policy" {
  name        = "media_files_bucket_writer_policy"
  description = "policy allowing writing to the media files bucket"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:Put*",
          "s3:Delete*"
        ]
        Resource = [
          aws_s3_bucket.bucket.arn
        ]
      },
    ]
  })
}