variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-2"
}

variable "env" {
  type    = string
  default = "PROJECT"
}

variable "product" {
  type    = string
  default = ""
}

variable "dir_type" {
  type    = string
  default = "SimpleAD"
}

variable "az_names" {
  type    = list(string)
  default = [""]
}

variable "vpc_cidr" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet_cidr_blocks" {
  type    = list(string)
  default = [""]
}

variable "domain_name" {
}

variable "allocated_storage" {
}


variable "engine_name" {
}

variable "engine_version" {
}

variable "db_instance_type" {
}

variable "db_name" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}
