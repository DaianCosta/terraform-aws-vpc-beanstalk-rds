# Creating an Route Table for the public subnet!
resource "aws_route_table" "rt_private" {
  depends_on = [
    aws_vpc.custom,
    aws_nat_gateway.nat_gateway
  ]

  # VPC ID
  vpc_id = aws_vpc.custom.id

  # NAT Rule
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = format("%s-rt-private-%s", var.prefix, var.region)
  }
}