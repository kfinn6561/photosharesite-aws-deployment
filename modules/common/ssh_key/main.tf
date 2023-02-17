resource "tls_private_key" "RSA" {
  algorithm = "RSA"
}

resource "local_file" "private_key" {
  content  = tls_private_key.RSA.private_key_pem
  filename = pathexpand("${var.ssh_directory}/${var.key_name}.pem")
}

resource "local_file" "public_key" {
  content  = tls_private_key.RSA.public_key_openssh
  filename = pathexpand("${var.ssh_directory}/${var.key_name}.pub")
}