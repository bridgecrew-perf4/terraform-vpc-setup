resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.public.*.id[0]
  tags= {
    Name = "natGateway",
    build = var.build
  }
}

# eip for nat gateway
resource "aws_eip" "nat_gateway_eip" {
  vpc = true
  tags= {
    Name = "natGatewayEip",
    build = var.build
  }
}

# Route table: private route table with nat gateway
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }
  tags= {
    Name = "privateRouteTable",
    build = var.build
  }
}

