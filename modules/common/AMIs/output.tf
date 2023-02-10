output "ubuntu-ami-id" {
  value = data.aws_ami.ubuntu.id
  description = "AMI ID for the latest ubuntu image"
}