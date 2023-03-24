resource "random_password" "db-root-password" {
  length  = 16
  special = false
}

module "ssh_key" {
  source   = "../common/ssh_key"
  key_name = "pss-database-key"
}

resource "aws_security_group" "pss-db-security-groups" {
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    }
  ]
}

resource "aws_key_pair" "aws-ssh-key" {
  key_name   = module.ssh_key.key_name
  public_key = module.ssh_key.public_key
}

resource "aws_iam_role" "database-role" {
  name = "database_role"

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
  roles      = [aws_iam_role.database-role.name]
  policy_arn = var.bucket-reader-policy-arn
}

resource "aws_iam_instance_profile" "database-profile" {
  name = "database-profile"
  role = aws_iam_role.database-role.name
}

resource "aws_instance" "db" {
  ami                    = "ami-85a2ade3" #MySQL 5.7
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.aws-ssh-key.key_name
  vpc_security_group_ids = [aws_security_group.pss-db-security-groups.id]
  iam_instance_profile   = aws_iam_instance_profile.database-profile.name

  user_data = templatefile("${path.module}/startup.sh",
    {
      bucket-name   = var.deploy-support-bucket-id,
      database-name = var.database-name,
      db-password   = random_password.db-root-password
  })
  user_data_replace_on_change = true

  tags = {
    Name = "Database"
  }
}