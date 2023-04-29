output "endpoint" {
    value = aws_rds_cluster.cluster.endpoint
}

output "port" {
    value = aws_rds_cluster.cluster.port
}

output "username" {
    value = aws_rds_cluster.cluster.master_username
}

output "database" {
    value = aws_rds_cluster.cluster.database_name
}

output "password_generated"{
    value = random_password.db_master_pass.result
}