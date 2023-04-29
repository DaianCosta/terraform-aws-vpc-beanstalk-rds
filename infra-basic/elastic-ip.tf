# Creating an Elastic IP for the NAT Gateway!
resource "aws_eip" "nat_gateway_eip" {
  depends_on = [
    aws_vpc.custom
  ]
  vpc = true
  tags = {
    Name = format("%s-eip-%s", var.prefix, var.region)
  }
}