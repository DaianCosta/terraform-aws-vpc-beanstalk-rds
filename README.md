## infra-basic
Caso não possua uma VPC criada de forma adequada seguindo boas práticas, você poderá utilizar os manifestos abaixo:

- VPN
- subnete pública e privada
- NAT Gateway
- Tabela de roteamento pública e privada
- Internet Gateway
- Ilastic IP

## app

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_admin_secret"></a> [admin\_secret](#module\_admin\_secret) | git@github.com:youse-seguradora/terraform-aws-secretsmanager.git | v1.0.0 |
| <a name="module_sg_rds"></a> [sg\_rds](#module\_sg\_rds) | git@github.com:youse-seguradora/terraform-aws-security-group.git | v1.0.0 |

