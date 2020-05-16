output "aws-nginx-ip" {
  value = aws_instance.web1.public_ip
}

output "elastic_ip" {
  value = aws_eip.default.public_ip
}

output "elb-dns" {
    value = aws_elb.elb1.dns_name
}
