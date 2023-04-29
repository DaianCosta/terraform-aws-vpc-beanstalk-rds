#execute

terraform plan -var-file="production.tfvars"
terraform plan -var-file="integration.tfvars"
terraform plan -var-file="development.tfvars"

https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install-windows.html

passo a passo
eb init (só a primeira vez)
eb deploy Production --lavel 1.0.0 --staged