provider "aws" {
  # SETTING
  region = var.aws_region
  access_key = "AKIAJVBZCK3RWGHLAKGQ"
  secret_key = "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"

}


terraform {

    backend "local" {
        path = "terraform.tfstate"
    }
}