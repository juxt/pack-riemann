# Variables -----------------------------

variable "aws_profile" {}

variable "aws_region" {}

variable "availability_zone" {}

variable "system_name" {
  default = "all"
}

variable "riemann_ami" {}

variable "riemann_key_name" {}

variable "riemann_key_path" {}

variable "riemann_config_file" {}

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
  key_path           = "${var.riemann_key_path}"
  ami_image_id       = "${var.riemann_ami}"
  config_file        = "${var.riemann_config_file}"
}
