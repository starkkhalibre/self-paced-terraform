resource "aws_instance" "web-server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name


  provisioner "file" {
    source      = "${path.module}/index.html"
    destination = "/tmp/index.html"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y httpd;sudo cp /tmp/index.html /var/www/html/",
      "sudo service httpd restart",
      "sudo service httpd status"
    ]
  }
  connection {
    user        = "ec2-user"
    private_key = file("${path.module}/${var.private_key_path}")
    host        = aws_instance.web-server.public_ip
  }
}
