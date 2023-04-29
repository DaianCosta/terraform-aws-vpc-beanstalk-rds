resource "aws_vpc" "custom" {

  # IP Range for the VPC
  cidr_block = var.cidr_block

  # Enabling automatic hostname assigning
  enable_dns_hostnames = true
  tags = {
    Name = var.prefix
  }
}