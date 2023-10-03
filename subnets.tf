resource "aws_subnet" "public" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "10.80.0.0/20"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Public"
  }
}

resource "aws_subnet" "private" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "10.80.16.0/20"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Private"
  }
}
