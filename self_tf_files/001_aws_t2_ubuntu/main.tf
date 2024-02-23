# telling terraform that which provider to be choosen
provider "aws" {
    # telling terraform that which AWS region to be selected
    region = "us-east-1"
}

# telling terraform to create a "aws_instance" i.e ec2 instance 
# with the desired block name "practice_001"
resource "aws_instance" "practice_001" {
    # telling terraform to create a ec2 instance with the following ami
    ami             = "ami-0c7217cdde317cfec"
    # telling terraform to create a ec2 instance with the following instance type
    instance_type   = "t2.micro"
    # providing the user defined kep-pair file/.pem file
    key_name        = "hp_ubuntu" 
    # telling terraform to give the name of instance as "dummy002"
    tags = {
        Name = "dummy002"
    }
}