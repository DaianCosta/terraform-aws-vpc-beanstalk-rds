variable "region" {
  type        = string
  description = ""
}
#beanstalk-app
variable "application_name" {
  type = string
}
#beanstalk-environment
variable "env_name" {
  type = string
}
variable "solution_stack_name" {
  type = string
}
variable "tier" {
  default = "WebServer"
}
variable "vpc_id" {
  type        = string
  description = ""
}
variable "ec2_subnets" {
  type        = list(string)
  description = ""
}
variable "alb_subnets" {
  type        = list(string)
  description = ""
}
variable "min_instances" {
  type    = number
  default = 1
}
variable "max_instances" {
  type    = number
  default = 2
}
variable "instances_type" {
  type = string
}
variable "phpini_memory_limit" {
  type    = string
  default = "1G"
}

#database

variable "db_name" {
  type = string
}
variable "instance_class" {
  type = string
}

# Envs
variable "debug_display" {
  type = string
}

variable "url" {
  type = string
}

variable "db_host" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type = string
}

variable "auth_salt" {
  type = string
}

variable "nonce_key" {
  type = string
}

variable "secure_auth_key" {
  type = string
}

variable "auth_key" {
  type = string
}

variable "secure_auth_salt" {
  type = string
}

variable "logged_in_salt" {
  type = string
}

variable "logged_in_key" {
  type = string
}

variable "nonce_salt" {
  type = string
}

variable "healthcheck_url" {
  type    = string
  default = "/"
}

variable "healthcheck_interval" {
  type        = number
  default     = 10
  description = "The interval of time, in seconds, that Elastic Load Balancing checks the health of the Amazon EC2 instances of your application"
}

variable "healthcheck_timeout" {
  type        = number
  default     = 5
  description = "The amount of time, in seconds, to wait for a response during a health check. Note that this option is only applicable to environments with an application load balancer"
}

variable "healthcheck_healthy_threshold_count" {
  type        = number
  default     = 3
  description = "The number of consecutive successful requests before Elastic Load Balancing changes the instance health status"
}

variable "healthcheck_unhealthy_threshold_count" {
  type        = number
  default     = 3
  description = "The number of consecutive unsuccessful requests before Elastic Load Balancing changes the instance health status"
}

variable "healthcheck_httpcodes_to_match" {
  type        = list(string)
  default     = ["200"]
  description = "List of HTTP codes that indicate that an instance is healthy. Note that this option is only applicable to environments with a network or application load balancer"
}

#https
variable "loadbalancer_certificate_arn" {
  type = string
}

variable "application_port" {
  type    = number
  default = 80
}

variable "loadbalancer_redirect_http_to_https" {
  type        = bool
  default     = true
  description = "Redirect HTTP traffic to HTTPS listener"
}

variable "loadbalancer_redirect_http_to_https_priority" {
  type        = number
  default     = 1
  description = "Defines the priority for the HTTP to HTTPS redirection rule"
}

variable "loadbalancer_redirect_http_to_https_path_pattern" {
  type        = list(string)
  default     = ["*"]
  description = "Defines the path pattern for the HTTP to HTTPS redirection rule"
}

variable "loadbalancer_redirect_http_to_https_host" {
  type        = string
  default     = "#{host}"
  description = "Defines the host for the HTTP to HTTPS redirection rule"
}

variable "loadbalancer_redirect_http_to_https_port" {
  type        = string
  default     = "443"
  description = "Defines the port for the HTTP to HTTPS redirection rule"
}

variable "loadbalancer_redirect_http_to_https_status_code" {
  type        = string
  default     = "HTTP_301"
  description = "The redirect status code"

  validation {
    condition     = contains(["HTTP_301", "HTTP_302"], var.loadbalancer_redirect_http_to_https_status_code)
    error_message = "Allowed values are \"HTTP_301\" or \"HTTP_302\"."
  }
}

variable "loadbalancer_ssl_policy" {
  type        = string
}

variable "ipv6_cidr_blocks_public_ec2" {
  type        = string
  description = ""
}

variable "role_beanstalk" {
  type = string
}

# Elastic File Storage (Environment variables)

variable "efs_mount_directory" {
  type    = string
  default = ""
}

variable "key_par" {
  type = string
  default = ""
}

variable "autoscale_measure_name" {
  type        = string
  default     = "CPUUtilization"
  description = "Metric used for your Auto Scaling trigger"
}

variable "autoscale_statistic" {
  type        = string
  default     = "Average"
  description = "Statistic the trigger should use, such as Average"
}

variable "autoscale_unit" {
  type        = string
  default     = "Percent"
  description = "Unit for the trigger measurement, such as Bytes"
}

variable "autoscale_lower_bound" {
  type        = number
  default     = 20
  description = "Minimum level of autoscale metric to remove an instance"
}

variable "autoscale_lower_increment" {
  type        = number
  default     = -1
  description = "How many Amazon EC2 instances to remove when performing a scaling activity."
}

variable "autoscale_upper_bound" {
  type        = number
  default     = 80
  description = "Maximum level of autoscale metric to add an instance"
}

variable "autoscale_upper_increment" {
  type        = number
  default     = 1
  description = "How many Amazon EC2 instances to add when performing a scaling activity"
}