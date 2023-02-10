variable "key_name" {
  description = "the name of the ssh key on aws"
  type = "string"
}

variable "ssh_directory" {
  description = "directory to store the ssh keys"
  type = "string"
  default = "~/.ssh"
}