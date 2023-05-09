
# Create elastic beanstalk Environment
resource "aws_elastic_beanstalk_environment" "env" {
  name                = var.env_name
  cname_prefix        = format("%s-%s", lower(var.env_name), lower(var.application_name))
  application         = var.application_name
  solution_stack_name = var.solution_stack_name
  tier                = var.tier

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", var.ec2_subnets)
  }

  setting {
    namespace = "aws:ec2:vpc"
    name = "ELBSubnets"
    value = join(",", var.alb_subnets)
  }


   #SG the instance
  setting {
    name      = "SecurityGroups"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = aws_security_group.env_sg.id
  }

  #SG the ALB
  setting {
    name      = "SecurityGroups"
    namespace = "aws:elbv2:loadbalancer"
    value     = aws_security_group.alb_sg.id
  }

  setting {
    name      = "ManagedSecurityGroup"
    namespace = "aws:elbv2:loadbalancer"
    value     = aws_security_group.alb_sg.id
  }


  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = var.role_beanstalk
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = var.ipv6_cidr_blocks_public_ec2
  }

  setting {
    name      = "ProxyServer"
    namespace = "aws:elasticbeanstalk:environment:proxy"
    value     = "nginx"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "HealthCheckInterval"
    value     = var.healthcheck_interval
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "HealthyThresholdCount"
    value     = var.healthcheck_healthy_threshold_count
  }

  setting{
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "UnhealthyThresholdCount"
    value     = var.healthcheck_unhealthy_threshold_count
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "HealthCheckPath"
    value     = var.healthcheck_url
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = join(",", sort(var.healthcheck_httpcodes_to_match))
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "HealthCheckTimeout"
    value     = var.healthcheck_timeout
  }

  setting {
    namespace = "aws:elb:listener:443"
    name      = "InstancePort"
    value     =  var.application_port
  }

  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "Protocol"
    value     = "HTTPS"
  }

  setting {
    namespace = "aws:elbv2:listener:default"
    name      = "ListenerEnabled"
    value     = "true"
  }

  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "ListenerEnabled"
    value     = "true"
  }

  setting{
    namespace = "aws:elbv2:listener:443"
    name      = "SSLCertificateArns"
    value     = var.loadbalancer_certificate_arn
  }

  setting{
    namespace = "aws:elbv2:listener:443"
    name      = "SSLPolicy"
    value     =  var.loadbalancer_ssl_policy
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instances_type
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = var.min_instances
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.max_instances
  }

  ##===Autoscale trigger === ###

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "MeasureName"
    value     = var.autoscale_measure_name
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "Statistic"
    value     = var.autoscale_statistic
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "Unit"
    value     = var.autoscale_unit
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "LowerThreshold"
    value     = var.autoscale_lower_bound
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "LowerBreachScaleIncrement"
    value     = var.autoscale_lower_increment
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "UpperThreshold"
    value     = var.autoscale_upper_bound
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "UpperBreachScaleIncrement"
    value     = var.autoscale_upper_increment
    resource  = ""
  }

  setting {
    name      = "memory_limit"
    namespace = "aws:elasticbeanstalk:container:php:phpini"
    value     = var.phpini_memory_limit
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = var.key_par
    resource  = ""
  }

  # Envs
  setting {
    name      = "WP_DEBUG_DISPLAY"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.debug_display
  }

  setting {
    name      = "URL"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.url
  }

  setting {
    name      = "WP_HOME"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.url
  }

  setting {
    name      = "WP_SITEURL"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.url
  }

  setting {
    name      = "DB_HOST"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.db_host
  }

  setting {
    name      = "DB_USER"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.db_user
  }

  setting {
    name      = "DB_PASSWORD"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.db_password
  }

  setting {
    name      = "DB_NAME"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.db_name
  }

  setting {
    name      = "AUTH_SALT"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.auth_salt
  }

  setting {
    name      = "NONCE_KEY"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.nonce_key
  }

  setting {
    name      = "SECURE_AUTH_KEY"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.secure_auth_key
  }

  setting {
    name      = "AUTH_KEY"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.auth_key
  }

  setting {
    name      = "SECURE_AUTH_SALT"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.secure_auth_salt
  }

  setting {
    name      = "LOGGED_IN_SALT"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.logged_in_salt
  }

  setting {
    name      = "LOGGED_IN_KEY"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.logged_in_key
  }

  setting {
    name      = "NONCE_SALT"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.nonce_salt
  }

  # EFS
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "EFS_ID"
    value     = "${aws_efs_file_system.file_storage.id}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "EFS_MOUNT_DIRECTORY"
    value     = "${var.efs_mount_directory}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "AWS_REGION"
    value     = "${var.region}"
  }

}

data "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_elastic_beanstalk_environment.env.load_balancers[0]
  port = 80
}


resource "aws_lb_listener_rule" "redirect_http_to_https" {
  listener_arn = data.aws_lb_listener.http_listener.arn
  priority     = var.loadbalancer_redirect_http_to_https_priority

  condition {
    path_pattern {
      values = var.loadbalancer_redirect_http_to_https_path_pattern
    }
  }

  action {
    type = "redirect"
    redirect {
      host        = var.loadbalancer_redirect_http_to_https_host
      port        = var.loadbalancer_redirect_http_to_https_port
      protocol    = "HTTPS"
      status_code = var.loadbalancer_redirect_http_to_https_status_code
    }
  }
}