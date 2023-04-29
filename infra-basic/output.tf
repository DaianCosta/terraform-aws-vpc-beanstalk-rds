output "vpc_id" {
  value = aws_vpc.custom.id
}

output "subnet_public_a" {
  value = aws_subnet.subnet_public_a
}

output "subnet_public_b" {
  value = aws_subnet.subnet_public_b
}

output "subnet_private_a" {
  value = aws_subnet.subnet_private_a
}

output "subnet_private_b" {
  value = aws_subnet.subnet_private_b
}
