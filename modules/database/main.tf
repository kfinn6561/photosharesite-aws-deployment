
resource "aws_instance" "db" {
  ami           = "ami-85a2ade3" #MySQL 5.7
  instance_type = "t2.micro"

  tags = {
    Name = "Database"
  }
}