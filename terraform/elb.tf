resource "aws_elb" "elb2" {
    name = "terraform-elb-2"
    security_groups = [
        aws_security_group.elbsg.id
    ]
    subnets = [
        aws_subnet.public_us_west_2a.id,
        aws_subnet.public_us_west_2b.id
    ]
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
