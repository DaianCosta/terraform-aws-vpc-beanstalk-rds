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

| Variable | Value |
|------|--------|
| xxx | v1.0.0 |
| xxx | v1.0.0 |

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

#comandos

```hcl
terraform init
terraform fmt
terraform plan
terraform apply
```


