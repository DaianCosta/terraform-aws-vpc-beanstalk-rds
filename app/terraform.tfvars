#beanstalk-app
application_name = "e-farmacias-daian-teste"

db_name_basic    = "efarmaciasdaian"

#beanstalk-environment
vpc_id                       = "vpc-029e5188aed8d38fa"
private_subnets              = ["subnet-1a", "1b"]
public_subnets               = ["subnet-2a", "2b"]
region                       = "us-east-1"
loadbalancer_certificate_arn = "<rout certificate>"
loadbalancer_ssl_policy      = "your ssl"
ipv6_cidr_blocks_public_ec2  = "false"
role_beanstalk               = "aws-elasticbeanstalk-ec2-role"
key_par                      = "devops-aws"