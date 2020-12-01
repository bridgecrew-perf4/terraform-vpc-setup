# VPC
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  tags = {
    Name = "vpc-${var.build}",
    build =var.build
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw",
    build =var.build
  }
}

# Subnets : management - to ssh
resource "aws_subnet" "bastion" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.bastion_subnet_cidr
  availability_zone = element(var.azs,0)
  tags = {
    Name = "Bastion-Subnet",
    build = var.build
  }
}

# Subnets : public
resource "aws_subnet" "public" {
  count = length(var.ext_subnets_cidr)
  vpc_id = aws_vpc.vpc.id
  cidr_block = element(var.ext_subnets_cidr,count.index)
  availability_zone = element(var.azs,count.index)
  tags = {
    Name = "Ext-Subnet-${count.index+1}",
    build = var.build
  }
}

# Subnets : private
resource "aws_subnet" "private" {
  count = length(var.int_subnets_cidr)
  vpc_id = aws_vpc.vpc.id
  cidr_block = element(var.int_subnets_cidr,count.index)
  availability_zone = element(var.azs,count.index)
  tags = {
    Name = "Int-Subnet-${count.index+1}",
    build = var.build
  }
}

# Subnets : db
resource "aws_subnet" "db" {
  count = length(var.db_subnets_cidr)
  vpc_id = aws_vpc.vpc.id
  cidr_block = element(var.db_subnets_cidr,count.index)
  availability_zone = element(var.azs,count.index)
  tags = {
    Name = "DB-Subnet-${count.index+1}",
    build = var.build
  }
}

# Route table: attach Internet Gateway 
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags= {
    Name = "publicRouteTable",
    build = var.build
  }
}

# Route table association with public subnets
resource "aws_route_table_association" "route_table_assoc_public" {
  count = length(var.ext_subnets_cidr)
  subnet_id      = element(aws_subnet.public.*.id,count.index)
  route_table_id = aws_route_table.public_rt.id
}

# Route table association with management subnet
resource "aws_route_table_association" "route_table_assoc_bastion" {
  subnet_id      = aws_subnet.bastion.id
  route_table_id = aws_route_table.public_rt.id
}

# Route table association with private subnets
resource "aws_route_table_association" "route_table_assoc_private" {
  count = length(var.int_subnets_cidr)
  subnet_id      = element(aws_subnet.private.*.id,count.index)
  route_table_id = aws_route_table.private_rt.id
}


# Route table association with db subnets
resource "aws_route_table_association" "route_table_assoc_db" {
  count = length(var.db_subnets_cidr)
  subnet_id      = element(aws_subnet.db.*.id,count.index)
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_key_pair" "bastion_key_pair" {
  key_name   = "bastion_key"
  public_key = file("id_rsa.pub")
}