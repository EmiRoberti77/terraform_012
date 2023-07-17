provider "aws" {
  region = "eu-west-2"
}

resource "aws_db_instance" "myRDS" {
  db_name           = "clive"
  identifier       = "clive"
  instance_class   = "db.t3.micro"
  engine           = "postgres"
  engine_version   = "14.8"
  license_model    = "postgresql-license"
  username         = "clive"
  password         = "password"
  allocated_storage = 20
  port             = 5432
}