provider "aws" {
  region = "eu-west-2"
}

module "ec2Module" {
  source = "./ec2"
  ec2name = "Emi EC2 Instance"
}

output "ec2Module_instance_id_output" {
  value = module.ec2Module.instance_id
}

output "ec2Module_name_output" {
  value = module.ec2Module.instance_ami
}