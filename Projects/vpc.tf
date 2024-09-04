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

resource "aws_instance" "praveen_instance" {
  ami                         = "ami-04a81a99f5ec58529"
  subnet_id                   = aws_subnet.praveen_public_subnet["pb_subnet_1"].id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  tags = {
    Name = "${local.praveen}_ec2"
  }
}

output "ec2_instance_public_ip" {
  value = aws_instance.praveen_instance.public_ip
}