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