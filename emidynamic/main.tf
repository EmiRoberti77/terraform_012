provider "aws" {
  region = "eu-west-2"
}

variable "ingressrules" {
  type = list(number)
  default = [ 80, 443 , 25, 3306, 53, 8080]
}

resource "aws_instance" "ec2" {
    ami = "ami-0cc7e32fa3b6695a5"
    instance_type = "t4g.micro"
    security_groups = [aws_security_group.webtraffic.name]
}

resource "aws_security_group" "webtraffic" {
  name = "Allow Web Traffic"
  description = "Allow Web Traffic"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
      from_port = port.value
      to_port = port.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.ingressrules
    content {
      from_port = port.value
      to_port = port.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}