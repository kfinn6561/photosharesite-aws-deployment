resource "random_password" "admin-pwd" {
  length  = 16
  special = false
}

resource "aws_instance" "db" {
  ami           = "ami-85a2ade3" #MySQL 5.7
  instance_type = "t2.micro"
  user_data     = templatefile("${path.module}/startup.sh", {})

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("/home/rahul/Jhooq/keys/aws/aws_key")
    timeout     = "4m"
  }

  tags = {
    Name = "Database"
  }
}