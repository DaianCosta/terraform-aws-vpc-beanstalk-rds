#beanstalk-app
variable "application_name" {
  type = string
}

variable "vpc_id" {
  type        = string
  description = ""
}
variable "public_subnets" {
  type        = list(string)
  description = ""
}
variable "private_subnets" {
  type        = list(string)
  description = ""
}
variable "region" {
  type        = string
  description = ""
}

variable "loadbalancer_certificate_arn" {
  type        = string
  description = ""
}

variable "loadbalancer_ssl_policy" {
  type        = string
  description = ""
}

variable "ipv6_cidr_blocks_public_ec2" {
  type        = string
  description = ""
}

variable "role_beanstalk" {
  type = string
}

variable "db_name_basic" {
  type = string
}