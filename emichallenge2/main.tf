provider "aws" {
  region = "eu-west-2"
}

module "dbserver" {
  source = "./db"
  name = "DB Server - Emi"
}

output "db_server_id" {
  value = module.dbserver.dbserver_id
}

output "db_server_private_ip" {
  value = module.dbserver.dbserver_private_ip
}

module "webserver" {
  source = "./web"
  name = "Web Server - Emi"
  ingress = [80, 443]
  egress = [80, 443]
}

output "web_server_external_ip" {
  value = module.webserver.eip
}