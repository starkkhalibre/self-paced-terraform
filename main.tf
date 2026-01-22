terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

module "ec2_instance" {
  source = "./modules/aws-instance-first-script"
}

module "ebs_with_userdata" {
  source = "./modules/ebs-with-userdata"
}

module "ec2_with_webserver" {
  source = "./modules/ec2-webserver"
}

module "software_provision" {
  source = "./modules/Software-provision"
}

module "autoscaling" {
  source = "./modules/terraform-aws-autoscaling"
}

module "vpc_ebs" {
  source = "./modules/terraform-aws-ebs"
}

module "iam" {
  source = "./modules/terraform-aws-iam/iam"
}

module "iam_role_with_instance" {
  source = "./modules/terraform-aws-iam/iam_role_with_instance"
}

module "private_public_subnets" {
  source = "./modules/terraform-aws-private-public-ip"
}

module "dynamodb" {
  source = "./modules/terraform-aws-rds-dynamoDb"
}

module "rds" {
  source = "./modules/terraform-aws-rds-mariaDb"
}

module "vpc" {
  source = "./modules/terraform-aws-vpc"
}
