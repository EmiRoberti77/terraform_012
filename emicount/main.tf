provider "aws" {
  region = "eu-west-2"
}

module "db" {
  source = "./db"
  server_names = ["database1", "database2", "database3"]
}

output "private_ips" {
  value = module.db.PrivateIP
}