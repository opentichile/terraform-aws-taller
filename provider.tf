provider "aws" {

  region = var.aws.region

  # AWS_ACCESS_KEY_ID
  access_key = "AKIAJVBZCK3RWGHLAKGQ"
  # AWS_SECRET_ACCESS_KEY
  secret_key = "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"

}


terraform {

    backend "local" {
        path = "terraform.tfstate"
    }
}