resource "aws_eip" "gw_ip" {
  vpc = true
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"
    
  tags = {
    Name = "main"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.gw_ip.id}"
  subnet_id = "${aws_subnet.public.id}"
  depends_on = [aws_internet_gateway.gw]
}
