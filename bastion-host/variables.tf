variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "key_par" {
  type = string
}

variable "name_instance" {
  type = string
}
variable "vpc_id" {
  type        = string
  description = ""
}
variable "region" {
  type        = string
  description = ""
}
