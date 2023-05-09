#beanstalk-app
application_name = "e-farmacias-daian-teste"

db_name_basic    = "efarmaciasdaian"

#beanstalk-environment
vpc_id                       = "vpc-029e5188aed8d38fa"
private_subnets              = ["subnet-0f9b6cc186af08d5f", "subnet-01d34aade4d1385c6"]
public_subnets               = ["subnet-0f9b6cc186af08d5f", "subnet-01d34aade4d1385c6"]
region                       = "us-east-1"
loadbalancer_certificate_arn = "arn:aws:acm:us-east-1:430080514437:certificate/faab7e59-598f-4936-bfba-45b14ba0f516"
loadbalancer_ssl_policy      = "ELBSecurityPolicy-FS-2018-06"
ipv6_cidr_blocks_public_ec2  = "true"
role_beanstalk               = "aws-elasticbeanstalk-ec2-role"
key_par                      = "devops-aws"