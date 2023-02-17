resource "random_string" "bucket_ending" {
  length    = 4
  min_lower = 4
}

resource "aws_s3_bucket" "bucket" {
  bucket = "kieran-finn-pss-deployment-support-${random_string.bucket_ending.result}"
  force_destroy = true

  tags = {
    Name = "pss-deployment-support"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

resource "aws_s3_object" "db-procedures" {
  for_each = fileset("${var.database-directory}/procedures", "**")
  bucket   = aws_s3_bucket.bucket.id
  key      = "procedures/${each.value}"
  source   = "${var.database-directory}/procedures/${each.value}"
  etag     = filemd5("${var.database-directory}/procedures/${each.value}")
}

resource "aws_s3_object" "db-tables" {
  for_each = fileset("${var.database-directory}/tables", "**")
  bucket   = aws_s3_bucket.bucket.id
  key      = "tables/${each.value}"
  source   = "${var.database-directory}/tables/${each.value}"
  etag     = filemd5("${var.database-directory}/tables/${each.value}")
}