# Riemann role
resource "aws_security_group" "internal_inbound" {
  name        = "internal_inbound"
  description = "Allow access to Riemann Server"

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    # ideally

    # cidr_blocks = ["10.0.0.0/14"]
  }

  ingress {
    from_port   = 5555
    to_port     = 5555
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.system_name}_transactors"
  }
}

data "template_file" "install_user_data" {
  template = "${file("${path.module}/files/install.sh")}"

  vars {}
}

resource "aws_instance" "riemann" {
  ami               = "${var.ami_image_id}"
  instance_type     = "${var.instance_type}"
  availability_zone = "${var.availability_zones[0]}"
  security_groups   = ["${aws_security_group.internal_inbound.id}"]

  user_data = "${data.template_file.install_user_data.rendered}"
  key_name  = "${var.key_name}"

  tags {
    key                 = "Name"
    value               = "${var.system_name}-transactor"
    propagate_at_launch = true
  }

  tags {
    key                 = "Type"
    value               = "Riemann"
    propagate_at_launch = true
  }
}
