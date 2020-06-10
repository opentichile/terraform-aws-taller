provider "aws" {

  region = var.aws.region

  # AWS_ACCESS_KEY_ID
  access_key = "*******************"
  # AWS_SECRET_ACCESS_KEY
  secret_key = "****************"

}


terraform {

    backend "local" {
        path = "terraform.tfstate"
    }
}
