resource "random_password" "admin-pwd" {
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

resource "aws_instance" "db" {
  ami                    = "ami-85a2ade3" #MySQL 5.7
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.aws-ssh-key.key_name
  vpc_security_group_ids = [aws_security_group.pss-db-security-groups.id]

  user_data = templatefile("${path.module}/startup.sh", {})

  tags = {
    Name = "Database"
  }
}