resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  instance_tenancy     = "default"

  tags = {
    Name = format("%s-%s-vpc", var.prefix, random_pet.this.id)
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = 2
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnets[count.index].cidr
  map_public_ip_on_launch = "true"
  availability_zone       = format("%s%s", var.region, var.subnets[count.index].az)

  tags = {
    Name = format("%s-public-subnet-%s", var.prefix, count.index)
  }
}

resource "aws_subnet" "private_subnets" {
  count                   = 2
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnets[count.index + 2].cidr
  map_public_ip_on_launch = "true"
  availability_zone       = format("%s%s", var.region, var.subnets[count.index + 2].az)

  tags = {
    Name = format("%s-private-subnet-%s", var.prefix, count.index + 2)
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = format("%s-%s-igw", var.prefix, random_pet.this.id)
  }
}


resource "aws_eip" "nat" {
  domain = "vpc"
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = [for key, subnet in aws_subnet.public_subnets : subnet.id][0]

  tags = {
    Name = format("%s-%s-nat", var.prefix, random_pet.this.id)
  }
}


resource "aws_route_table" "public_routetable" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = format("%s-%s-public-route-table", var.prefix, random_pet.this.id)
  }
}


resource "aws_route_table" "private_routetable" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = format("%s-%s-private-route-table", var.prefix, random_pet.this.id)
  }
}


resource "aws_route_table_association" "public_subnets" {
  count = 2

  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_routetable.id
}


resource "aws_route_table_association" "private_subnets" {
  count = 2

  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_routetable.id
}
