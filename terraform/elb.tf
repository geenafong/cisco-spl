resource "aws_elb" "elb1" {
    name = "terraform-elb"
    availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
    security_groups = [aws_security_group.elbsg.id]

    listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
    }
    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 3
        target = "HTTP:80/"
        interval = 30
    }

    instances = [aws_instance.web1.id,aws_instance.web2.id]
    cross_zone_load_balancing = true
    idle_timeout = 400
    connection_draining = true
    connection_draining_timeout = 400

    tags = {
        Name = "terraform-elb"
    }
}

output "aws-nginx-ip" {
  value = "${aws_instance.web2.public_ip}"
}

output "elb-dns" {
    value = aws_elb.elb1.dns_name
}
