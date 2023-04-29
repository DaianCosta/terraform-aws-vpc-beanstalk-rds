
# Creating Private subnet A!
resource "aws_subnet" "subnet_private_a" {
  depends_on = [
    aws_vpc.custom
  ]

  # VPC in which subnet has to be created!
  vpc_id = aws_vpc.custom.id

  # IP Range of this subnet
  cidr_block = var.subnet_private_a

  # Data Center of this subnet.
  availability_zone = format("%s%s", var.region, local.zone.a)

  # Enabling automatic public IP assignment on instance launch!
  map_public_ip_on_launch = false

  tags = {
    Name = format("%s-sub-private-%s%s", var.prefix, var.region, local.zone.a)
  }
}


# Creating Private subnet B!
resource "aws_subnet" "subnet_private_b" {
  depends_on = [
    aws_vpc.custom
  ]

  # VPC in which subnet has to be created!
  vpc_id = aws_vpc.custom.id

  # IP Range of this subnet
  cidr_block = var.subnet_private_b

  # Data Center of this subnet.
  availability_zone = format("%s%s", var.region, local.zone.b)

  # Enabling automatic public IP assignment on instance launch!
  map_public_ip_on_launch = false

  tags = {
    Name = format("%s-sub-private-%s%s", var.prefix, var.region, local.zone.b)
  }
}