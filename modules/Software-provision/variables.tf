variable "region" {
  type    = string
  default = "ap-southeast-1"
}
variable "private_key_path" {
  type    = string
  default = ""
}

variable "ami_id" {
  type    = string
  default = "ami-01dc51e87421923b6"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  type    = string
  default = "terraform"
}
