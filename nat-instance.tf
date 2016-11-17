/* NAT/VPN server */
resource "aws_instance" "nat" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public.id}"
  security_groups = ["${aws_security_group.default.id}", "${aws_security_group.nat.id}"]
  key_name = "deployer"
  source_dest_check = false
  tags = {
    Name = "alti-nat-instance"
  }
  connection {

  type = "ssh"
   user = "ubuntu"
   private_key = "${file("C:/TERRAFORM/deployer.pem")}"
   timeout = "2m"
   agent = false
     }
  provisioner "remote-exec" {
    inline = [
      "sudo iptables -t nat -A POSTROUTING -j MASQUERADE",
      "echo 1 | sudo tee /proc/sys/net/ipv4/conf/all/forwarding > /dev/null",
          ]
  }
}
