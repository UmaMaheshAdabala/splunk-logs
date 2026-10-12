resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnet_cidr_blocks)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "${var.vpc_name}-public-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet_cidr_blocks)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "${var.vpc_name}-private-subnet"
  }
}

resource "aws_subnet" "db_subnet" {
  count             = length(var.db_subnet_cidr_blocks)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.db_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "${var.vpc_name}-db-subnet"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = length(var.public_subnet_cidr_blocks)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.vpc_name}-private-rt"
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  count          = length(var.private_subnet_cidr_blocks)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table" "db_route_table" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.vpc_name}-db-rt"
  }
}

resource "aws_route_table_association" "db_subnet_association" {
  count          = length(var.db_subnet_cidr_blocks)
  subnet_id      = aws_subnet.db_subnet[count.index].id
  route_table_id = aws_route_table.db_route_table.id
}

resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name = "${var.vpc_name}-nat-eip"
  }
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet[0].id
  tags = {
    Name = "${var.vpc_name}-nat-gateway"
  }
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id
}

