variable "name" {
  type = string
}

resource "aws_instance" "webserver" {
  ami = "ami-032598fcc7e9d1c7a"
  instance_type = "t2.micro"
  user_data = file("./web/server-script.sh")
  tags = {
    Name = var.name
  }
}

variable "ingress" {
    type = list(number)
}

variable "egress" {
    type = list(number)
}

resource "aws_security_group" "web_traffic" {
    name = "Allow Web Traffic"

    dynamic "ingress" {
        iterator = port
        for_each = var.ingress
        content {
            from_port = port.value
            to_port = port. value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

        dynamic "egress" {
        iterator = port
        for_each = var.egress
        content {
            from_port = port.value
            to_port = port. value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
}

resource "aws_eip" "eip" {
  instance = aws_instance.webserver.id
}

output "webserver_id" {
  value = aws_instance.webserver.id
}

output "eip" {
  value = aws_eip.eip.public_ip
}