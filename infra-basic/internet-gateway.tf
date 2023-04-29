# Creating an Internet Gateway for the VPC
resource "aws_internet_gateway" "internet_gateway" {
  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet_public_a,
    aws_subnet.subnet_public_b
  ]

  # VPC in which it has to be created!
  vpc_id = aws_vpc.custom.id

  tags = {
    Name = format("%s-igw-%s", var.prefix, var.region)
  }
}