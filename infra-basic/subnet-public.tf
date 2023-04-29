# Creating Public subnet A!
resource "aws_subnet" "subnet_public_a" {
  depends_on = [
    aws_vpc.custom
  ]

  # VPC in which subnet has to be created!
  vpc_id = aws_vpc.custom.id

  # IP Range of this subnet
  cidr_block = var.subnet_public_a
  # Data Center of this subnet.
  availability_zone = format("%s%s", var.region, local.zone.a)

  # Enabling automatic public IP assignment on instance launch!
  map_public_ip_on_launch = true

  tags = {
    Name = format("%s-sub-public-%s%s", var.prefix, var.region, local.zone.a)
  }
}

# Creating Public subnet B!
resource "aws_subnet" "subnet_public_b" {
  depends_on = [
    aws_vpc.custom
  ]

  # VPC in which subnet has to be created!
  vpc_id = aws_vpc.custom.id

  # IP Range of this subnet
  cidr_block = var.subnet_public_b
  # Data Center of this subnet.
  availability_zone = format("%s%s", var.region, local.zone.b)

  # Enabling automatic public IP assignment on instance launch!
  map_public_ip_on_launch = true

  tags = {
    Name = format("%s-sub-public-%s%s", var.prefix, var.region, local.zone.b)
  }
}