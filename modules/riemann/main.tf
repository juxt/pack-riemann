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
    cidr_blocks = ["${var.cidr}"]
  }

  tags {
    Name = "${var.system_name}_riemann"
  }
}

resource "aws_instance" "riemann" {
  ami                    = "${var.ami_image_id}"
  instance_type          = "${var.instance_type}"
  availability_zone      = "${var.availability_zones[0]}"
  vpc_security_group_ids = ["${aws_security_group.inbound.id}"]
  key_name               = "${var.key_name}"
  private_ip             = "${var.private_ip}"

  tags {
    Name = "${var.system_name}riemann"
    Type = "Riemann"
  }

  connection {
    user        = "ubuntu"
    private_key = "${file("${var.key_path}")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo touch /etc/riemann.config",
      "sudo chown -R ubuntu:ubuntu /etc/riemann.config",
    ]
  }

  provisioner "file" {
    source      = "${var.config_file}"
    destination = "/etc/riemann.config"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo systemctl start riemann",
      "sudo systemctl start riemann-dash",
    ]
  }
}
