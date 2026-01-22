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

resource "aws_instance" "rds_example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_1.id

  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
  # Remove availability_zone or set it properly
  # availability_zone = "ap-southeast-1a"  # Match subnet's AZ
  
  key_name = var.key_name

  user_data = <<-EOF
#!/bin/bash
sudo yum update -y
sudo yum install -y httpd mariadb105
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
echo "<p>Database Endpoint: ${aws_db_instance.default.endpoint}</p>" | sudo tee -a /var/www/html/index.html
EOF

  tags = {
    Name = "RDS_MariaDB_Example"
  }
}

output "public_ip" {
  value = aws_instance.rds_example.public_ip
}
