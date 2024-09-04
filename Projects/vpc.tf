provider "aws" {
  profile = "default"
}

locals {
  praveen = "praveen"
}

resource "aws_vpc" "praveen_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.praveen}_vpc"
  }
}

resource "aws_subnet" "praveen_public_subnet" {
  vpc_id            = aws_vpc.praveen_vpc.id
  for_each          = var.public_subnet_cidr
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az
  tags = {
    Name = each.key
  }
}

resource "aws_subnet" "praveen_private_subnet" {
  for_each          = var.private_subnet_cidr
  vpc_id            = aws_vpc.praveen_vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    Name = each.key
  }
}

resource "aws_internet_gateway" "praveen-IGW" {
  vpc_id = aws_vpc.praveen_vpc.id

  tags = {
    Name = "${local.praveen}_IGW"
  }
}

resource "aws_route_table" "praveen-rt-public" {
  vpc_id = aws_vpc.praveen_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.praveen-IGW.id
  }

  tags = {
    Name = "public_rt_${local.praveen}"
  }
}

resource "aws_route_table_association" "praveen-public-rt-association" {
  for_each       = aws_subnet.praveen_public_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.praveen-rt-public.id
}

resource "aws_route_table" "praveen-rt-private" {
  vpc_id = aws_vpc.praveen_vpc.id
  tags = {
    Name = "private_rt_${local.praveen}"
  }
}

resource "aws_route_table_association" "praveen-private-rt-association" {
  for_each       = aws_subnet.praveen_private_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.praveen-rt-private.id
}

resource "aws_security_group" "cicd-sg" {
  name = "cicd-SG"
  description = "cicd_security_group"
}

resource "aws_security_group_rule" "name" {
  type = "ingress"
  protocol = "tcp"
  security_group_id = aws_security_group.cicd-sg.id
  to_port = 22
  from_port = 22
}