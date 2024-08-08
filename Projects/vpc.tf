provider "aws" {
    access_key = ""
    secret_key = ""
    region = "us-east-1"
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
    vpc_id = aws_vpc.praveen_vpc
    cidr_block = "10.0.1.0/24"
    tags = {
        Name = "${local.praveen}_public_subnet"
    }
}

resource "aws_subnet" "praveen_private_subnet" {
    vpc_id = aws_vpc.praveen_vpc
    cidr_block = "10.0.3.0/24"
    tags = {
        Name = "${local.praveen}_private_subnet"
    }
}

resource "aws_instance" "praveen_instance" {
    ami = ""
    instance_type = var.instance_type
    count = 1
    tags = {
        Name = "${local.praveen}_ec2"
    }
}

output "ec2_instance_public_ip" {
    value = aws_instance.praveen_instance.public_ip
}
