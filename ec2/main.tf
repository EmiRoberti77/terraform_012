provider "aws" {
    region = "eu-west-2"
}

resource "aws_instance" "ec2" {
    ami = "ami-0cc7e32fa3b6695a5"
    instance_type = "t4g.micro"
}