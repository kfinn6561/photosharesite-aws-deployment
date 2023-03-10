output "ubuntu-ami-id" {
  value       = data.aws_ami.ubuntu.id
  description = "AMI ID for the latest ubuntu image"
}

output "amazon-linux-ami-id" {
  value       = data.aws_ami.amazon_linux.id
  description = "AMI ID for the latest amazon linux image"
}