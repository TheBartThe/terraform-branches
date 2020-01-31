variable "environment" {
}
variable "region" {
}
variable "credentials" {
}
variable "ami_id" {
}
variable "key_pair" {
}
variable "open_internet" {
}
variable "instance_type" {
}
variable "asg_start" {
}
variable "asg_stop" {
}

provider "aws" {
  version                 = "~> 2.7"
  region                  = var.region
  shared_credentials_file = var.credentials
}
module "infrastructure" {
  source        = "../../modules/infrastructure"
  environment   = var.environment
  region        = var.region
  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_pair      = var.key_pair
  open_internet = var.open_internet
  asg_start     = var.asg_start
  asg_stop      = var.asg_stop
}
