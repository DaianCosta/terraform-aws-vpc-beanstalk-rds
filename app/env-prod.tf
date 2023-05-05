locals {
  env_name_prod = "production"
}

module "env_prod" {
  source = "./modules/env"

  #terraform.tfvars
  application_name            = aws_elastic_beanstalk_application.app.name
  solution_stack_name         = "64bit Amazon Linux 2 v3.5.5 running PHP 8.1"
  vpc_id                      = var.vpc_id
  ec2_subnets                 = var.private_subnets
  alb_subnets                 = var.public_subnets
  ipv6_cidr_blocks_public_ec2 = var.ipv6_cidr_blocks_public_ec2
  role_beanstalk              = var.role_beanstalk

  #beanstalk
  env_name            = local.env_name_prod
  instances_type      = "t4g.medium"
  min_instances       = 2
  max_instances       = 5
  phpini_memory_limit = "4G"

  #db
  db_host        = format("%s:%d", module.rds_prod.endpoint, module.rds_prod.port)
  instance_class = "db.t2.medium"
  db_name        = module.rds_prod.database
  db_user        = module.rds_prod.username
  db_password    = module.rds_prod.password_generated

  #wp
  debug_display    = 0
  url              = format("http://%s-%s.%s.elasticbeanstalk.com", lower(local.env_name_prod), lower(var.application_name), var.region)
  auth_key         = "{vZ9^>U~d6*hmR|W#$a&-0`eqFp} %?9>w$hoJC|iK6$kDX(p|P6(89TeAm`Z5gj"
  auth_salt        = "a=sQmzl0m_DUJxlP-m~{5lnk;9nwccVS:#q@+/TB$d,2yjmVaM7>L|MyQ:[E/cF~"
  logged_in_key    = "{l56 ohIi#Ex^Fp;!1m.4n|{iWwz(~m|?=h| 2U~9:,+dnazTP`S^VZ~GWXBp+|m"
  logged_in_salt   = "Sr0sHxb,n!/+VW:-aY);*dIZ[jY_# 5/DkPg0~q`h+lEyRaLPtf]Am|7(Xo?xYU5"
  nonce_key        = "^B?b`|%,#~i*JBnq}q3SU-.YCHOnK+OxQlz;CS}{NYDK/o@l(yu(iJEcrWxTn+Zg"
  nonce_salt       = "),GM)I~|f(k_f%*<yg9>V<5|&HZ+qA,)M9%?1!i@iKR $y;o(1~dQ]anGlJI4om#"
  secure_auth_key  = ";U1yA/i#J@Hm#-Lgrr~L$]QD+<jj`@ouQ+9SUe8Dff$ps(%jC#Td|pa5IZN2c:5M"
  secure_auth_salt = "VkszZ1vO4N+cQz*B/*J0)L&/+!L%f*cj*W.V%ezQ~s?p^&{s,T$!945po8Ld^w;c"

  loadbalancer_certificate_arn = var.loadbalancer_certificate_arn
  loadbalancer_ssl_policy      = var.loadbalancer_ssl_policy

  region = var.region
  efs_mount_directory = "/var/app/efs"
}