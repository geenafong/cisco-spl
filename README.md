# aws-ec2-instance-with-nginx-and-elb
This example uses Terraform to create an AWS ELB in front of two EC2 instances running Ubuntu Linux. One of the instances configures an nginx web server.

# Usage
To run this example run the following commands:
```
terraform init
terraform plan
terraform apply -var 'key_name={your_key_name}'
```

It takes a couple of minutes for the user data to install ngnix. After a couple of minutes, type in the Elastic IP from the terraform outputs to see one of the two webpages. Refresh the page to alternate between the two pages.
