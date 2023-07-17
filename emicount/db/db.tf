variable "server_names" {
  type = list(string)
}

resource "aws_instance" "db" {
    ami = "ami-0cc7e32fa3b6695a5"
    instance_type = "t4g.micro"
    count = length(var.server_names)
    tags = {
        Name = var.server_names[count.index]
    }
}

output "PrivateIP" {
  value = [aws_instance.db.*.private_ip]
}