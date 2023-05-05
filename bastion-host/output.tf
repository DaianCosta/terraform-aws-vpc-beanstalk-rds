output "server_private_ip" {
  value = aws_instance.ec2-web.private_ip
}
output "server_public_ipv4" {
  value = aws_instance.ec2-web.public_ip
}
output "server_id" {
  value = aws_instance.ec2-web.id
}