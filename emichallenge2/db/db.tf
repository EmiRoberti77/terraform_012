variable "name" {
  type = string
}

resource "aws_instance" "dbInstance" {
  ami = "ami-032598fcc7e9d1c7a"
  instance_type = "t2.micro"
  tags = {
    Name = var.name
  }
}

output "dbserver_id" {
  value = aws_instance.dbInstance.id
}

output "dbserver_private_ip" {
  value = aws_instance.dbInstance.private_ip
}

