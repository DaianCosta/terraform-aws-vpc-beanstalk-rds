
# Creating a NAT Gateway!
resource "aws_nat_gateway" "nat_gateway" {
  depends_on = [
    aws_eip.nat_gateway_eip,
    aws_subnet.subnet_public_a
  ]

  # Allocating the Elastic IP to the NAT Gateway!
  allocation_id = aws_eip.nat_gateway_eip.id

  # Associating it in the Public Subnet!
  subnet_id = aws_subnet.subnet_public_a.id
  tags = {
    Name = format("%s-nat-%s%s", var.prefix, var.region, local.zone.a)
  }
}