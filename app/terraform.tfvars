#beanstalk-app
application_name = "e-myproject-daian-teste"
db_name_basic    = "myproject"
#beanstalk-environment
vpc_id                       = "vpc-id"
private_subnets              = ["subnet-id-a-1", "subnet-id-b-1"]
public_subnets               = ["subnet-id-a-2", "subnet-id-b-2"]
region                       = "us-east-1"
loadbalancer_certificate_arn = "your arn from certificate"
loadbalancer_ssl_policy      = "yout police ssl" #example ELBSecurityPolicy-FS-2018-06
ipv6_cidr_blocks_public_ec2  = "false"
role_beanstalk               = "yout role from ec2" #aws-elasticbeanstalk-ec2-role
