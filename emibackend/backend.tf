terraform {
    backend "s3" {
        key = "terraform/tfstate.tfstate"
        bucket = "emi-remote-terraform-backend-2023"
        region = "eu-west-2"

    }
}