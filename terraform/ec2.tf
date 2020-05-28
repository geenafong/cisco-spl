resource "aws_launch_configuration" "web2" {
    name_prefix = "terraform-lc-example-"
    image_id = lookup(var.aws_amis, var.aws_region)
    instance_type = "t2.micro"
    security_groups = [aws_security_group.websg.id]
    key_name = "Geena's Key Pair"
    associate_public_ip_address = true
    iam_instance_profile = aws_iam_instance_profile.ecs_instance_profile.name
    user_data = "#!/bin/bash\necho ECS_CLUSTER='${var.ecs_cluster_name}' > /etc/ecs/ecs.config"

    lifecycle {
        create_before_destroy = true
    }

}

resource "aws_ecs_cluster" "main" {
    name = var.ecs_cluster_name
}

resource "aws_autoscaling_group" "ecs-cluster" {
    name = "ECS ${var.ecs_cluster_name}"
    min_size = 1
    max_size = 3
    desired_capacity = 2
    health_check_type = "EC2"
    launch_configuration = "${aws_launch_configuration.web2.name}"
    vpc_zone_identifier  = flatten([
        aws_subnet.public_us_west_2a.*.id,
        aws_subnet.public_us_west_2b.*.id
    ])
}

resource "aws_ecs_task_definition" "test-http" {
    family = "test-http"
    container_definitions = "${file("task-definitions/test-http.json")}"
}

resource "aws_ecs_service" "test-http" {
    name = "test-http"
    cluster = "${aws_ecs_cluster.main.id}"
    task_definition = "${aws_ecs_task_definition.test-http.arn}"
    iam_role = "${aws_iam_role.ecs_service_role.arn}"
    desired_count = 2
    depends_on = ["aws_iam_role_policy.ecs_service_role_policy"]

    load_balancer {
        elb_name = "${aws_elb.elb.id}"
        container_name = "test-http"
        container_port = 80
    }
}