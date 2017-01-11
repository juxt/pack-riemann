output "riemann_ip" {
  value = "${aws_instance.riemann.public_ip}"
}

output "instance_id" {
  value = "${aws_instance.riemann.id}"
}
