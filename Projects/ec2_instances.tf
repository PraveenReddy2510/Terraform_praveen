resource "aws_key_pair" "key-pair" {
  key_name   = "cicd-key"
  public_key = file("~/.ssh/cicd-key.pub")
}

resource "aws_instance" "praveen_pt_instance" {
  ami = "ami-04a81a99f5ec58529"
  # subnet_id                   = aws_subnet.praveen_public_subnet["pb_subnet_1"].id
  for_each                    = aws_subnet.praveen_private_subnet
  subnet_id                   = each.value.id
  instance_type               = var.instance_type
  associate_public_ip_address = false
  key_name                    = aws_key_pair.key-pair.key_name
  security_groups = [
    aws_security_group.cicd-sg.id
  ]
  tags = {
    Name = "praveen_pt_ec2"
  }
}

resource "aws_instance" "praveen_pb_instance" {
  ami                         = "ami-04a81a99f5ec58529"
  subnet_id                   = aws_subnet.praveen_public_subnet["pb_subnet_1"].id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  key_name                    = aws_key_pair.key-pair.key_name
  user_data = file("~/shell_scripts/ubuntu.sh")
  security_groups = [
    aws_security_group.cicd-sg.id
  ]
  tags = {
    Name = "praveen_pb_ec2"
  }
}

output "ec2_instance_public_ip" {
  value = aws_instance.praveen_pb_instance.public_ip
}