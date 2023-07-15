provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "ec2" {
    ami = "ami-0cc7e32fa3b6695a5"
    instance_type = "t4g.micro"
    security_groups = [aws_security_group.webtraffic.name]
}

resource "aws_security_group" "webtraffic" {
  name = "Allow Web Traffic"
  description = "Allow Web Traffic"

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}