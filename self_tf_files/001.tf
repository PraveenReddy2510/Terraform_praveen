resource "aws_instance" "praveen-ec2" {
  ami           = "ami-0c94855ba95c286c99"
  instance_type = "t2.micro"
}
