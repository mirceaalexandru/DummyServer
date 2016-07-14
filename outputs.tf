/*App instances*/
output "test-dummy-ip" {
  value = "${aws_instance.test.public_ip}"
}

output "web-public-ip" {
  value = "${aws_eip.web.public_ip}"
}
