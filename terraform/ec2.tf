data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_vpc" "selected" {
}

resource "aws_instance" "web1" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.websg.id]
    user_data = <<-EOF
    #!/bin/bash
    echo "hello, I am web1" >index.html
    nohup busybox httpd -f -p 80 &
    EOF

    lifecycle {
    create_before_destroy = true
    }

    tags = {
        Name = "terraform-web1"
    }
}

resource "aws_instance" "web2" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.websg.id]
    key_name = "Geena's Key Pair"

    user_data = <<-EOF
    #!/bin/bash
    echo "hello, I am Web2" >index.html
    nohup busybox httpd -f -p 80 &
    EOF

    lifecycle {
        create_before_destroy = true
    }

    tags = {
        Name = "terraform-web2"
    }
}
