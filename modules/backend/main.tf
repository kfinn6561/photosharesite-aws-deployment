resource "aws_iam_role" "backend-role" {
  name = "backend_role"

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

resource "aws_iam_policy_attachment" "bucket-reader-attach" {
  name       = "bucket-reader-attachment"
  roles      = [aws_iam_role.backend-role.name]
  users      = [aws_iam_user.backend-user.name]
  policy_arn = var.bucket-reader-policy-arn
}

resource "aws_iam_policy_attachment" "bucket-writer-attach" {
  name       = "bucket-writer-attachment"
  roles      = [aws_iam_role.backend-role.name]
  users      = [aws_iam_user.backend-user.name]
  policy_arn = var.bucket-writer-policy-arn
}

resource "aws_iam_policy_attachment" "password-reader-attach" {
  name       = "password-reader-attachment"
  roles      = [aws_iam_role.backend-role.name]
  users      = [aws_iam_user.backend-user.name]
  policy_arn = var.db-password-secret-reader-policy-arn
}

resource "aws_iam_user" "backend-user" {
  force_destroy = true
  name          = "backend-user"
}

resource "aws_iam_access_key" "backend-user-access-key" {
  user = aws_iam_user.backend-user.name
}