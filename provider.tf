provider "aws" {
  # SETTING
  region     = var.aws_region
  access_key = "AKIAVDUWQRCUQPFX354A"
  secret_key = "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"

}


terraform {

  backend "local" {
    path = "terraform.tfstate"
  }
}
