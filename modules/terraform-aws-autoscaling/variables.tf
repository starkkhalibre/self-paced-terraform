variable "region" {
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

variable "subnets" {
  type    = list(string)
  default = ["subnet-068ea84fd8d56faf8", "subnet-0d7b812cb3231f148"]
}

variable "azs" {
  type    = list(string)
  default = ["ap-southeast-1a", "ap-southeast-1b"]
}

variable "security_grpup_id" {
  type    = string
  default = "sg-04b54aaf8448d8642"
}
