resource "aws_instance" "web2" {
    ami = "${lookup(var.aws_amis, var.aws_region)}"
    instance_type = "t2.micro"
    security_groups = ["${aws_security_group.websg.name}"]
    key_name = "Geena's Key Pair"

    user_data = <<-EOF
    #!/bin/bash
    echo “hello, I am Web2” >index.html
    nohup busybox httpd -f -p 80 &
    EOF

    lifecycle {
        create_before_destroy = true
    }

    tags = {
        Name = "terraform-web2"
    }
}

resource "aws_instance" "web1" {
    ami = "${lookup(var.aws_amis, var.aws_region)}"
    instance_type = "t2.micro"
    security_groups = ["${aws_security_group.websg.name}"]
    key_name = "Geena's Key Pair"

    user_data = file("user_data.sh")

    lifecycle {
        create_before_destroy = true
    }

    tags = {
        Name = "terraform-web1"
    }
}

resource "aws_eip" "default" {
  instance = "${aws_instance.web1.id}"
  vpc      = true
}
