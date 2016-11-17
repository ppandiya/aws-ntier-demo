/* App servers */
resource "aws_instance" "app" {
  count = 2
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.private.id}"
  security_groups = ["${aws_security_group.default.id}"]
  key_name = "deployer"
  source_dest_check = false
  user_data = "${file("C:/Users/ppandiyan/aws-ntier-demo/cloud-config/app.yml")}"
  tags = {
    Name = "alti-web-server-${count.index}"
  }
}

/* Load balancer */
resource "aws_elb" "app" {
  name = "alti-demo-elb"
  subnets = ["${aws_subnet.public.id}"]
  security_groups = ["${aws_security_group.default.id}", "${aws_security_group.web.id}"]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  instances = ["${aws_instance.app.*.id}"]
}
