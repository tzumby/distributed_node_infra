resource "aws_instance" "ssh_bastion" {
  ami           = "ami-024e6efaf93d85776"
  instance_type = "t3.micro"
  subnet_id     = "${aws_subnet.public.id}"
  key_name      = "raz"

  associate_public_ip_address = true

  vpc_security_group_ids = [
    "${aws_security_group.sg_bastion.id}"
  ]

  tags = {
    Name  = "ssh_bastion"
  }
}

resource "aws_instance" "private_node" {
  ami           = "ami-024e6efaf93d85776"
  instance_type = "t3.micro"
  subnet_id     = "${aws_subnet.private.id}"
  key_name      = "raz"
  count         = 2

  associate_public_ip_address = false

  vpc_security_group_ids = [
    "${aws_security_group.private_node.id}"
  ]

  tags = {
    Name  = "private_node"
  }
}
