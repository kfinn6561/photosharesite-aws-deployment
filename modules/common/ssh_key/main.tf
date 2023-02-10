resource "tls_private_key" "ed25519" {
  algorithm = "ED25519"
}

resource "local_file" "private_key" {
  content  = tls_private_key.ed25519.private_key_pem
  filename = "${var.ssh_directory}/${var.key_name}.pem"
}

resource "local_file" "public_key" {
  content  = tls_private_key.ed25519.public_key_openssh
  filename = "${var.ssh_directory}/${var.key_name}.pub"
}