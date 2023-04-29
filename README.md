## infra-basic
Caso não possua uma VPC criada de forma adequada seguindo boas práticas, você poderá utilizar os manifestos abaixo:

- VPN
- subnete pública e privada
- NAT Gateway
- Tabela de roteamento pública e privada
- Internet Gateway
- Ilastic IP

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

Configurações do RDS
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

#comandos

```hcl
terraform init
terraform fmt
terraform plan
terraform apply
```


