data "aws_canonical_user_id" "current" {}

resource "random_string" "bucket_ending" {
  length    = 4
  min_lower = 4
}

resource "aws_s3_bucket" "bucket" {
  bucket        = "kieran-finn-pss-deployment-support-${random_string.bucket_ending.result}"
  force_destroy = true

  tags = {
    Name = "pss-deployment-support"
  }
}

resource "aws_iam_role" "bucket-reader-role" {
  name = "bucket_reader_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}


resource "aws_iam_policy" "bucket-reader-policy" {
  name        = "bucket_reader_policy"
  description = "policy allowing reading of the deploy support bucket"

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
          aws_s3_bucket.bucket.arn
        ]
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "bucket-reader-attach" {
  name       = "bucket-reader-attachment"
  roles      = [aws_iam_role.bucket-reader-role.name]
  policy_arn = aws_iam_policy.bucket-reader-policy.arn
}

resource "aws_iam_instance_profile" "bucket-reader-profile" {
  name = "bucket-reader-profile"
  role = aws_iam_role.bucket-reader-role.name
}

resource "aws_s3_bucket_acl" "pss-deploy-support-bucket-acl" {
  bucket = aws_s3_bucket.bucket.id
  access_control_policy {
    grant {
      grantee {
        id   = aws_iam_instance_profile.bucket-reader-profile.id
        type = "CanonicalUser"
      }
      permission = "READ"
    }

    owner {
      id = data.aws_canonical_user_id.current.id
    }
  }
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