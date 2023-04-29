
resource "aws_route_table_association" "rt_public_associate_a" {

  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet_public_a,
    aws_route_table.rt_public
  ]

  # Public Subnet ID
  subnet_id = aws_subnet.subnet_public_a.id

  #  Route Table ID
  route_table_id = aws_route_table.rt_public.id
}

resource "aws_route_table_association" "rt_public_associate_b" {

  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet_public_b,
    aws_route_table.rt_public
  ]

  # Public Subnet ID
  subnet_id = aws_subnet.subnet_public_b.id

  #  Route Table ID
  route_table_id = aws_route_table.rt_public.id
}