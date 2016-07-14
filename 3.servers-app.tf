resource "aws_instance" "test" {
  instance_type = "${var.instance_type}"

  # Lookup the correct AMI based on the region
  # we specified
  ami = "${lookup(var.amis, var.region)}"

  subnet_id = "${aws_subnet.test.id}"

  key_name = "${aws_key_pair.deployer.key_name}"

  security_groups = ["${aws_security_group.web.id}"]

  connection {
    user = "ubuntu"
    private_key = "${file("ssh/test")}"
  }

  # prepare app folder and install required packages
  provisioner "remote-exec" {
    inline = [
      "mkdir /tmp/app",
      "sudo apt-get update -y",
      "curl -sSL https://get.docker.com/ | sudo sh",
      "sudo usermod -aG docker ubuntu"
    ]
  }

  # copy project files
  provisioner "file" {
    source = "./"
    destination = "/tmp/app"
  }

  # build and run docker
  provisioner "remote-exec" {
    inline = [
      "docker build -t dummy /tmp/app/.",
      "docker run -d --net=host --restart=on-failure:20 -p 3000:3000 dummy",
    ]
  }

  #Instance tags
  tags {
    Name = "test-dummy"
  }
}
