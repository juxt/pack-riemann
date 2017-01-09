# Variables -----------------------------

variable "aws_profile" {}

variable "aws_region" {}

variable "availability_zone" {}

variable "system_name" {}

variable "riemann_ami" {}

variable "riemann_key_name" {}

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
  key_name           = "${var.riemann_key_name}"
  ami_image_id       = "${var.riemann_ami}"
}
