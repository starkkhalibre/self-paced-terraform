variable "region" {
  type    = string
  default = "ap-southeast-1"
}
variable "ami_id" {
  type    = string
  default = "ami-01dc51e87421923b6"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "device_name" {
  type    = string
  default = "/dev/xvdh"
}

variable "ebs_size" {
  type    = string
  default = "20"
}

variable "key_name" {
  type    = string
  default = "NEW-SSHKEY"
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "10.0.0.0/16"
}
variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = string
  default     = "Vpc-custom-demo"
}
