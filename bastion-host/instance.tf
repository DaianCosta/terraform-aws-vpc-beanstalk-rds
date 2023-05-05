resource "aws_instance" "ec2-web" {
  ami                         = var.ami # us-west-2
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  security_groups             = [aws_security_group.bastion_host_sg.id]
  key_name                    = var.key_par
  associate_public_ip_address = true

  tags = {
    Name = format("%s-instance", var.name_instance)
  }
}
