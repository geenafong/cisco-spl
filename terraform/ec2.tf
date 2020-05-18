resource "aws_launch_configuration" "web2" {
    name_prefix = "web-"
    image_id = lookup(var.aws_amis, var.aws_region)
    instance_type = "t2.micro"
    security_groups = [aws_security_group.websg.id]
    key_name = "Geena's Key Pair"
    associate_public_ip_address = true

    user_data = file("user_data.sh")

    lifecycle {
        create_before_destroy = true
    }

}
