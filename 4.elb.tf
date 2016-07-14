# Create a new load balancer
resource "aws_elb" "test" {
  name = "test-terraform-elb"

  subnets = ["${aws_subnet.test.id}"]
  security_groups = ["${aws_security_group.elb.id}"]

  listener {
    instance_port = 3000
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:3000/ping"
    interval = 30
  }

  instances = ["${aws_instance.test.id}"]
  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  tags {
    Name = "test-terraform-elb"
  }
}
