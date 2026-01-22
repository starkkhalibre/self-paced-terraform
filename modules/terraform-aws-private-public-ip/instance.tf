terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}


provider "aws" {
  region = var.region
}

resource "aws_instance" "IP_example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_1.id

  # Security group assign to instance
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  private_ip = "10.0.1.10"
  # key name
  key_name = var.key_name

  user_data = <<EOF
#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
EOF

  tags = {
    Name = "Private_IP"
  }
}

resource "aws_eip" "eip" {
  instance = aws_instance.IP_example.id
  domain   = "vpc"
}

output "public_ip" {
  value = aws_instance.IP_example.public_ip
}
