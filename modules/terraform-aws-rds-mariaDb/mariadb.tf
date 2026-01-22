resource "aws_db_parameter_group" "default" {
  name   = "mariadb-params"
  family = "mariadb10.11"

  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }

  tags = {
    Name = "MariaDB Parameter Group"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "main-db-subnet"
  subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]  # Fixed: list of 2 subnets

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mariadb"
  engine_version         = "10.11"
  instance_class         = "db.t3.micro"
  db_name                = "mydb"
  username               = "admin"
  password               = "foobarbaz"  # Use variables in production!
  parameter_group_name   = aws_db_parameter_group.default.name
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.db.id]
  skip_final_snapshot    = true
  
  tags = {
    Name = "MyDB Instance"
  }
}

output "endpoint" {
  value       = aws_db_instance.default.endpoint
  description = "RDS instance endpoint"
}

output "database_name" {
  value       = aws_db_instance.default.db_name
  description = "Database name"
}
