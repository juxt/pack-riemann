output "riemann_ip" {
  value = "${aws_instance.riemann.public_ip}"
}
