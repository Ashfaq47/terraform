resource "aws_vpc" "vpc1" {
  cidr_block = var.CIDR

  tags = {
    Name = var.vpcname
  }
}

resource "aws_subnet" "subnets" {
  count                   = length(var.subnet_names)
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = cidrsubnet(var.CIDR, 2, count.index)
  availability_zone       = var.subnet_azs[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet_names[count.index]
  }
  depends_on = [aws_vpc.vpc1]
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = var.igw_name
  }
  depends_on = [aws_vpc.vpc1, aws_subnet.subnets]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "web_subnet"
  }
  depends_on = [aws_vpc.vpc1, aws_subnet.subnets]
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id

  depends_on = [aws_route_table.public, aws_vpc.vpc1]
}


resource "aws_route_table_association" "public_asso" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.subnets[0].id

  depends_on = [aws_subnet.subnets]
}

resource "aws_route_table" "app_subnet" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "app_subnet"
  }
  depends_on = [aws_vpc.vpc1, aws_subnet.subnets]
}

resource "aws_route_table" "db_subnet1" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "db_subnet1"
  }
  depends_on = [aws_vpc.vpc1, aws_subnet.subnets]
}

resource "aws_route_table" "db_subnet2" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "db_subnet2"
  }
}




