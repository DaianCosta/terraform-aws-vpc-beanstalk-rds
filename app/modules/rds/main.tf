
resource "aws_db_subnet_group" "custom" {
  name       = format("subnet-rds-%s-custom",var.db_name)
  subnet_ids = var.subnets

  tags = {
    Name = format("subnet-rds-%s-custom",var.db_name)
  }
}

resource "aws_rds_cluster" "cluster" {
  cluster_identifier = format("cluster-%s",var.db_name)
  engine = var.engine
  engine_version = var.engine_version
  database_name = format("%s",var.db_name)
  master_username = var.db_username
  master_password = random_password.db_master_pass.result
  vpc_security_group_ids = [ aws_security_group.sg_rds.id ]
  db_subnet_group_name = aws_db_subnet_group.custom.name
  deletion_protection = var.deletion_protection
  #availability_zones = var.zones
  apply_immediately = true
  skip_final_snapshot = true
} 
 
resource "aws_rds_cluster_instance" "instance" {
  cluster_identifier = aws_rds_cluster.cluster.id
  identifier = format("instance-%s",var.db_name)
  instance_class = var.instance_class
  engine = aws_rds_cluster.cluster.engine
  engine_version = aws_rds_cluster.cluster.engine_version
  apply_immediately = true
}