# Riemann role
resource "aws_security_group" "inbound" {
  name        = "${var.system_name}-riemann"
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
  ami                    = "${var.ami_image_id}"
  instance_type          = "${var.instance_type}"
  availability_zone      = "${var.availability_zones[0]}"
  vpc_security_group_ids = ["${aws_security_group.inbound.id}"]

  user_data = "${data.template_file.install_user_data.rendered}"
  key_name  = "${var.key_name}"

  tags {
    Name = "${var.system_name}-riemann"
    Type = "Riemann"
  }
}
