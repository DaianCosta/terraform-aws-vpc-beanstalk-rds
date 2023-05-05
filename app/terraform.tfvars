#beanstalk-app
application_name = "e-farmacias-daian-teste"

db_name_basic    = "efarmaciasdaian"

#beanstalk-environment
vpc_id                       = "vpc-02ec7796534d195a6"
private_subnets              = ["subnet-00cb8dc524a869403", "subnet-0c01f3e920f201bd0"]
public_subnets               = ["subnet-0e1b95e5cd043c7e4", "subnet-0ac707eb6b0304edd"]
region                       = "us-east-1"
loadbalancer_certificate_arn = "arn:aws:acm:us-east-1:430080514437:certificate/faab7e59-598f-4936-bfba-45b14ba0f516"
loadbalancer_ssl_policy      = "ELBSecurityPolicy-FS-2018-06"
ipv6_cidr_blocks_public_ec2  = "false"
role_beanstalk               = "aws-elasticbeanstalk-ec2-role"
