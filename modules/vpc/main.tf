resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "private_subnet" {
  for_each    = var.subnets
  vpc_id      = aws_vpc.my_vpc.id
  cidr_block  = each.value
  availability_zone = each.key

  tags = {
    Name = "private-subnet-${each.key}"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

resource "aws_route_table_association" "public_association" {
  for_each      = aws_subnet.private_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}