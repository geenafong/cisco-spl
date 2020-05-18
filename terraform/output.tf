output "elb-dns" {
    value = aws_elb.elb2.dns_name
}
