provider "aws" {
  # SETTING
  region     = var.aws_region
  access_key = "AKIAVDUWQRCU2F5RFBKF"
  secret_key = "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"

}


terraform {

  backend "local" {
    path = "terraform.tfstate"
  }
}
