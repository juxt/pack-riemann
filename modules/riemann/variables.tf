variable "system_name" {}

variable "availability_zones" {
  type = "list"
}

variable "cidr" {}

variable "ami_image_id" {}

variable "instance_type" {
  default = "t2.medium"
}

variable "key_name" {}

variable "key_path" {}

variable "config_file" {}

variable "private_ip" {}
