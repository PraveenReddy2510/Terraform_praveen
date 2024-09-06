variable "instance_type" {
  type    = string
  default = "t2.medium"
}

variable "availability_zones" {
  description = "A list of availability zones"
  type        = map(string)
  default = {
    az1 = "us-east-1a"
    az2 = "us-east-1b"
  }
}

variable "vpc_cidr" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "public_subnet_cidr" {
  type = map(object({
    cidr_block = string
    az         = string
  }))
  default = {
    pb_subnet_1 = {
      cidr_block = "10.0.1.0/24"
      az         = "us-east-1a"
    }
    pb_subnet_2 = {
      cidr_block = "10.0.2.0/24"
      az         = "us-east-1b"
    }
  }
}

variable "private_subnet_cidr" {
  type = map(object({
    cidr_block = string
    az         = string
  }))
  default = {
    pt_subnet_1 = {
      cidr_block = "10.0.3.0/24"
      az         = "us-east-1a"
    }
    pt_subnet_2 = {
      cidr_block = "10.0.4.0/24"
      az         = "us-east-1a"
    }
    pt_subnet_3 = {
      cidr_block = "10.0.5.0/24"
      az         = "us-east-1a"
    }
    pt_subnet_4 = {
      cidr_block = "10.0.6.0/24"
      az         = "us-east-1b"
    }
    pt_subnet_5 = {
      cidr_block = "10.0.7.0/24"
      az         = "us-east-1b"
    }
    pt_subnet_6 = {
      cidr_block = "10.0.8.0/24"
      az         = "us-east-1b"
    }
  }
}

variable "pr-ec2-tags" {
  type = number
  default = 6
}