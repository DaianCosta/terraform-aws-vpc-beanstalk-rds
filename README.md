## infra-basic
Caso não possua uma VPC criada de forma adequada seguindo boas práticas, você poderá utilizar os manifestos abaixo:

- VPN
- subnete pública e privada
- NAT Gateway
- Tabela de roteamento pública e privada
- Internet Gateway
- Ilastic IP

comandos
```hcl
terraform init
terraform fmt
terraform plan
terraform apply
```
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
## app

| Variable | Value |
|------|--------|
| xxx | v1.0.0 |
| xxx | v1.0.0 |

#comandos
```hcl

terraform init
terraform fmt
terraform plan
terraform apply
```


