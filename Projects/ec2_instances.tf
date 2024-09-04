resource "aws_key_pair" "name" {
  key_name = "cicd-key"
  public_key = file("~/cicd-key.pub")
}

resource "aws_instance" "praveen_instance" {
  ami                         = "ami-04a81a99f5ec58529"
  subnet_id                   = aws_subnet.praveen_public_subnet["pb_subnet_1"].id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  key_name = "cicd-key"
  tags = {
    Name = "${local.praveen}_ec2"
  }
}

output "ec2_instance_public_ip" {
  value = aws_instance.praveen_instance.public_ip
}