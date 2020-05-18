# Default security group to access the instances over SSH and HTTP
resource "aws_security_group" "websg" {
    name = "security_group_for_web_server"
    description = "Allow HTTP inbound connections"
    vpc_id = aws_vpc.my_vpc.id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    # outbound internet access
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "Allow HTTP Security Group"
    }
}

# SSH access from anywhere
resource "aws_security_group_rule" "ssh" {
    security_group_id = aws_security_group.websg.id
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}


resource "aws_security_group" "elbsg" {
    name = "security_group_for_elb"
    description = "Allow HTTP traffic to instances through Elastic Load Balancer"
    vpc_id = aws_vpc.my_vpc.id

    # HTTP access from anywhere
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
}
    # outbound internet access
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "Allow HTTP through ELB Security Group"
    }
}
