resource "aws_vpc" "rds_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnets" {
  count                   = length(var.subnet_names)
  vpc_id                  = aws_vpc.rds_vpc.id
  map_public_ip_on_launch = true
  cidr_block              = cidrsubnet(var.vpc_cidr, 2, count.index)
  availability_zone       = var.azs[count.index]
  tags = {
    Name = var.subnet_names[count.index]
  }
  depends_on = [aws_vpc.rds_vpc]
}

resource "aws_internet_gateway" "new_igw" {
  vpc_id = aws_vpc.rds_vpc.id
  tags = {
    Name = var.igw
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.rds_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.new_igw.id
  }

  tags = {
    Name = "public_route"
  }

  depends_on = [aws_vpc.rds_vpc]
}

resource "aws_route_table_association" "public_route_asso" {
  route_table_id = aws_route_table.public_route.id
  subnet_id      = aws_subnet.subnets[0].id

  depends_on = [aws_vpc.rds_vpc, aws_route_table.public_route]
}

resource "aws_eip" "nat_eip" {
 
}

resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.subnets[0].id

  tags = {
    Name = var.NAT_name
  }

  depends_on = [aws_subnet.subnets, aws_eip.nat_eip]
}

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.rds_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT.id
  }

  tags = {
    Name = "private_route"
  }
}

resource "aws_route_table_association" "private_route_asso" {
  subnet_id      = aws_subnet.subnets[2].id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_route_asso_2" {
  subnet_id      = aws_subnet.subnets[3].id
  route_table_id = aws_route_table.private_route.id
}
