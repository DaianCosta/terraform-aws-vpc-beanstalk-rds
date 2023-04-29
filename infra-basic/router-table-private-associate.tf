
resource "aws_route_table_association" "rt_private_associate_a" {

  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet_private_a,
    aws_route_table.rt_private
  ]

  # Private Subnet ID
  subnet_id = aws_subnet.subnet_private_a.id

  #  Route Table ID
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "rt_private_associate_b" {

  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet_private_b,
    aws_route_table.rt_private
  ]

  # Private Subnet ID
  subnet_id = aws_subnet.subnet_private_b.id

  #  Route Table ID
  route_table_id = aws_route_table.rt_private.id
}