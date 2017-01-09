variable "system_name" {}

variable "availability_zones" {
  type = "list"
}

variable "ami_image_id" {
  default = "ami-0d77397e"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "key_name" {}
