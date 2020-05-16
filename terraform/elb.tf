resource "aws_elb" "elb1" {
    name = "terraform-elb"
    security_groups = [aws_security_group.elbsg.id]

    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }

    instances = [aws_instance.web1.id, aws_instance.web2.id]

    tags = {
        Name = "terraform-elb"
    }
}
