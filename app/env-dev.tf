locals {
  env_name_dev = "development"
}

module "env_dev" {
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
  env_name            = local.env_name_dev
  instances_type      = "t3.micro"
  min_instances       = 1
  max_instances       = 2
  phpini_memory_limit = "256M"

  #db
  db_host        = format("%s:%d", module.rds_dev.endpoint, module.rds_dev.port)
  instance_class = "db.t3.small"
  db_name        = module.rds_dev.database
  db_user        = module.rds_dev.username
  db_password    = module.rds_dev.password_generated

  #wp
  debug_display    = 0
  url              = format("http://%s-%s.%s.elasticbeanstalk.com", lower(local.env_name_dev), lower(var.application_name), var.region)
  auth_key         = "c1EnH~)aoac8G(uL#( k[&s7J_+6Nm+<T8QK/{}#R;Y>T2+]bYrw[2#]*4fP5MFf"
  auth_salt        = "a=sQmzl0m_DUJxlP-m~{5lnk;9nwccVS:#q@+/TB$d,2yjmVaM7>L|MyQ:[E/cF~"
  logged_in_key    = "9.q=G`+uh_sp+>Hui6.+MltSl<8XM.KXl/ 8&$2E-JV9)Ol+Wj`8%6-h~HHG_&)c"
  logged_in_salt   = "dH|hgo`)_c2x7EM@W|A+z(h.^yH9V{3LB|zPjhEs_wIRlZr#r*h,K}avCeOrG1DJ"
  nonce_key        = "oX6fwu8qYTW}m]5:Hi<N{sup!unadV=x< zOI5*ID3%WZ$2|ANmBdm]aS13KNcY;"
  nonce_salt       = "0T|osjt|DkId wd8Yu:uUQvUFqL-6i!Dr)Kr<Nvd]8[tS!5n4.2fN$m+?|C8c:%6"
  secure_auth_key  = "P4}sy#=PyRgnn|;*`&-83sz2fMWO5E0,&Rdi,j-C}6kb:Kl}Sv+z}I(-=bR$?#zm"
  secure_auth_salt = "Al0hp|+=rsuM(G*Fy*|=HE^f8g|H$J[+]x@7qD15H1Caa2<|2@;|9PohY I!X=Y?"

  loadbalancer_certificate_arn = var.loadbalancer_certificate_arn
  loadbalancer_ssl_policy      = var.loadbalancer_ssl_policy
}