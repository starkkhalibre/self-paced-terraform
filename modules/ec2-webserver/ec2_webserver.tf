resource "aws_instance" "ec2_jenkins" {
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name = var.key_name

  user_data = <<-EOF
#!/bin/bash
set -e
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "Starting user data script execution..."

# Update system
sudo dnf update -y

# Install Apache
sudo dnf install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
echo "User data script completed successfully!"
EOF

  user_data_replace_on_change = true

  tags = {
    Name = "Ec2-User-data"
  }
}
