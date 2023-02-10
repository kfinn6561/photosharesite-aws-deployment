resource "random_password" "admin-pwd" {
  length  = 16
  special = false
}

resource "aws_instance" "db" {
  ami           = "ami-85a2ade3" #MySQL 5.7
  instance_type = "t2.micro"
  user_data     = templatefile("${path.module}/startup.sh", {})
  tags = {
    Name = "Database"
  }
}