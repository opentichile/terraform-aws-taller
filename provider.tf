provider "aws" {

    region = var.aws.region

}


terraform {

    backend "local" {
        path = "terraform.tfstate"
    }
}