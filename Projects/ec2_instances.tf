resource "aws_key_pair" "key-pair" {
  key_name = "cicd-key"
  public_key = file("~/.ssh/cicd-key.pub")
}

resource "aws_instance" "praveen_instance" {
  ami                         = "ami-04a81a99f5ec58529"
  subnet_id                   = aws_subnet.praveen_public_subnet["pb_subnet_1"].id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  key_name = aws_key_pair.key-pair.key_name
  security_groups = [
    aws_security_group.cicd-sg 
    ]
  tags = {
    Name = "${local.praveen}_ec2"
  }
}

output "ec2_instance_public_ip" {
  value = aws_instance.praveen_instance.public_ip
}