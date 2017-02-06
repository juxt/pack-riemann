# Variables -----------------------------

variable "aws_profile" {}

variable "aws_region" {}

variable "cidr" {}

variable "availability_zone" {}

variable "system_name" {
  default = "all"
}

variable "ami" {}

variable "key_name" {}

variable "key_path" {}

variable "config_file" {}

variable "private_ip" {}

# Providers -----------------------------

provider "aws" {
  profile = "${var.aws_profile}"
  region  = "${var.aws_region}"
}

# Modules -----------------------------

module "staging_riemann" {
  source             = "./modules/riemann"
  availability_zones = ["${var.availability_zone}"]
  system_name        = "${var.system_name}"
  cidr               = "${var.cidr}"
  key_name           = "${var.key_name}"
  key_path           = "${var.key_path}"
  ami_image_id       = "${var.ami}"
  config_file        = "${var.config_file}"
  private_ip         = "${var.private_ip}"
}
