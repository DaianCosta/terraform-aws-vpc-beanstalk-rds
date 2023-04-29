variable "vpc_id" {
  type = string
}

variable "instance_class" {
    type = string
}

variable "sg_to_access" {
    type = list(string)
}

variable "db_name" {
    type = string
}

variable "db_username" {
    type = string
    default = "admin"
}

variable "db_password" {
    type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

# variable "zones" {
#   type = list(string)
# }

variable "subnets" {
  type = list(string)
}

variable "deletion_protection" {
  type = bool
  default = false
}
