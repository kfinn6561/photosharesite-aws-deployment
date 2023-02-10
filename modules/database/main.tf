resource "random_password" "admin-pwd" {
  length  = 16
  special = false
}

module "ssh_key" {
  source   = "../common/ssh_key"
  key_name = "pss-database-key"
}

resource "aws_key_pair" "aws-ssh-key" {
  key_name   = module.ssh_key.key_name
  public_key = module.ssh_key.public_key
}

resource "aws_instance" "db" {
  ami           = "ami-85a2ade3" #MySQL 5.7
  instance_type = "t2.micro"
  key_name      = aws_key_pair.aws-ssh-key.key_name

  user_data = templatefile("${path.module}/startup.sh", {})


  tags = {
    Name = "Database"
  }
}