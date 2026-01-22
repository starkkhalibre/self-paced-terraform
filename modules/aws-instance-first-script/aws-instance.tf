resource "aws_instance" "web1" {
  ami           = var.ami_id
  count         = var.instance_count
  instance_type = var.instance_type
  key_name      = var.key_name
}
