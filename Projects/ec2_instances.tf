resource "aws_key_pair" "name" {
  key_name = "cicd-key"
  public_key = file("~/cicd-key.pub")
}