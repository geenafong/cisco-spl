resource "aws_elb" "elb" {
    name = "terraform-elb"
    security_groups = [
        aws_security_group.elbsg.id
    ]
    subnets = [
        aws_subnet.public_us_west_2a.id,
        aws_subnet.public_us_west_2b.id
    ]
    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 3
        interval = 30
        target = "HTTP:80/"
    }
    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }

    tags = {
        Name = "terraform-elb"
    }
}
