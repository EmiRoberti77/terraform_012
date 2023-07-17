provider "aws" {
    region = "eu-west-2"
}

resource "aws_instance" "db" {
    ami = "ami-0cc7e32fa3b6695a5"
    instance_type = "t4g.micro"
}

resource "aws_instance" "db_2" {
    ami = "ami-0cc7e32fa3b6695a5"
    instance_type = "t4g.micro"
}

resource "aws_instance" "web" {
    ami = "ami-0cc7e32fa3b6695a5"
    instance_type = "t4g.micro"

    depends_on = [ aws_instance.db, aws_instance.db_2 ]
}
