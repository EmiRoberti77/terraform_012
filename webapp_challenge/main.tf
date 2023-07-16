provider "aws" {
    region = "eu-west-2"
}

variable "ingressrules" {
    type = list(number)
    default = [80,443]
}

variable "egressrules" {
    type = list(number)
    default = [80,443]
}

resource "aws_instance" "dbserver" {
    ami = "ami-032598fcc7e9d1c7a"
    instance_type = "t2.micro"
    tags = {
      Name = "dbserver"
    }
}

resource "aws_instance" "webserver" {
    ami = "ami-032598fcc7e9d1c7a"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.webtraffic.name]
    //bootstartup server script to starte http webserver
    user_data = file("server-script.sh")
    tags = {
      Name = "webserver"
    }
}

//create elastic ip to attach to webserver instance for public access
resource "aws_eip" "web_ip" {
  instance = aws_instance.webserver.id
  tags = {
    Name = "public emi webserver"
    description = "public emi webserver"
  }
}

resource "aws_security_group" "webtraffic" {
    name = "Allow HTTPS"

    dynamic "ingress" {
        iterator = port 
        for_each = var.ingressrules
        content {
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }

    dynamic "egress" {
        iterator = port 
        for_each = var.egressrules
        content {
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }
}

//print out private db server ip
output "dbserver_private_ip" {
    value = aws_instance.dbserver.private_ip
}

//print out private elastic ip for public access
output "eip_public_ip" {
    value = aws_eip.web_ip.public_ip
}