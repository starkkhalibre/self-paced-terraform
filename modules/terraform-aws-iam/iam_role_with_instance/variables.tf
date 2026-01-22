variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "ami_id" {
  type    = string
  default = "ami-01dc51e87421923b6"
}

variable "key_name" {
  type    = string
  default = "NEW-SSHKEY"
}


variable "instance_type" {
  type    = string
  default = "t3.micro"
}
