terraform {
    backend "s3" {
        key = "terraform/tfstate.tfstate"
        bucket = "tj-remote-backend-2020"
        region = "eu-west-2"
        
    }
}