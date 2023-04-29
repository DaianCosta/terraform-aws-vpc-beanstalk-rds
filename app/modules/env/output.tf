output "url" {
  value = aws_elastic_beanstalk_environment.env.endpoint_url
}

output "env_sg_id" {
  value = aws_security_group.env_sg.id
}