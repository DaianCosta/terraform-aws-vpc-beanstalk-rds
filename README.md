## infra-basic
Caso não possua uma VPC criada de forma adequada seguindo boas práticas, você poderá utilizar os manifestos abaixo:

- VPN
- subnete pública e privada
- NAT Gateway
- Tabela de roteamento pública e privada
- Internet Gateway
- Elastic IP

Acessar o diretório /infra-basica
cd /infra-basic

_terraform.tfvars_
```hcl
region            = "us-east-1"
prefix            = "vpc-efarmacias-teste"
cidr_block        = "10.0.0.0/16"
subnet_private_a = "10.0.1.0/24"
subnet_private_b = "10.0.2.0/24"
subnet_public_a  = "10.0.3.0/24"
subnet_public_b  = "10.0.4.0/24"
```
comandos
```hcl
terraform init
terraform fmt
terraform plan
terraform apply
```
## app
Esse módulo irá criar uma estrutura de dev/hml e prod no beanstalk, utilizando vpc, subnete privada e pública, com https e security group.
Também será criado duas bases de dados de dev/html e prod no rds aurora modo cluster.
A senha do banco de dados será gerada automatica e disponibilizada nas variáveis de ambiente do beanstalk.

Acessar o diretório /infra-basica
cd /app

_terraform.tfvars_
```hcl
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

```

Configurações dos ambientes, encontram nos arquivos específicos de cada ambiente

_rds-dev.tf_
```hcl
locals {
  rds_name_dev = "development"
}

module "rds_dev" {
  source = "./modules/rds"

  db_name        = format("%s%s", var.db_name_basic, local.rds_name_dev)
  engine         = "aurora-mysql"
  engine_version = "5.7.mysql_aurora.2.11.1"
  instance_class = "db.t3.small"
  db_username    = format("master_%s", local.rds_name_dev)
  db_password    = module.rds_dev.password_generated
  sg_to_access   = [module.env_dev.env_sg_id]
  vpc_id         = var.vpc_id
  subnets        = var.private_subnets
}
```
_rds-dev.tf_
```hcl
locals {
  rds_name_prod = "production"
}

module "rds_prod" {
  source = "./modules/rds"

  db_name        = format("%s%s", var.db_name_basic, local.rds_name_prod)
  engine         = "aurora-mysql"
  engine_version = "5.7.mysql_aurora.2.11.1"
  instance_class = "db.t3.medium"
  db_username    = format("master_%s", local.rds_name_prod)
  db_password    = module.rds_prod.password_generated
  sg_to_access   = [module.env_prod.env_sg_id]
  vpc_id         = var.vpc_id
  subnets        = var.private_subnets
}
```

_env-dev.tf_
```hcl
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
```

_env-prod.tf.tf_
```hcl
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
}
```

#comandos

```hcl
terraform init
terraform fmt
terraform plan
terraform apply
```


