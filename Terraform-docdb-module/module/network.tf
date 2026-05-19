resource "aws_vpc" "vpc_db" {
  cidr_block = var.cidr_block
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "aws_subnets" {
  count                   = length(var.subnet_names)
  vpc_id                  = aws_vpc.vpc_db.id
  map_public_ip_on_launch = true
  cidr_block              = cidrsubnet(var.cidr_block, 1, count.index)
  availability_zone       = var.availability_zone[count.index]
  tags = {
    Name = var.subnet_names[count.index]
  }

  depends_on = [aws_vpc.vpc_db]
}