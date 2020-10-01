# AWS EC2, ELB, Autoscaling, NGINX web server example
This example uses Terraform to create an AWS ELB in front of a dynamic number of EC2 instances, using Auto Scaling groups, to host a web server hosted by NGINX. For more information, reference the "Explanation of infrastructure" section below.

# Usage
To run this example run the following commands in the /terraform directory:
```
terraform init
terraform plan
terraform apply -var 'key_name={your_key_name}'

For a single command:
terraform init; terraform apply -var 'key_name={your_key_name}'
```
** Make sure that you add your key pair where it says `your_key_name`, to create one log into AWS, navigate to EC2, in Network and Security, click on Key Pairs and create one there.

It takes a couple of minutes for the user data to install ngnix. After a couple of minutes, type in the `elb-dns`from the terraform outputs to see the webpage.

# Explanation of infrastructure
- EC2s created via `aws_launch_configuration`
Contains all EC2 instance settings to apply to each new launched by Auto Scaling Group instance. The `user_data` parameter references our user_data.sh that offers scripted instructions for the instance to install and launch NGINX, executed at the instance boot time.
- Security Groups
We have three security groups which will allow HTTP connections to our instances:
1) For our web servers
2) To allow us to SSH into instances
3) For Elastic Load Balancing
- Load Balancer
An Elastic Load Balancer is used in front of our EC2 instances. This load balancer uses two subnets that look for the listener configuration that specifies elb port and protocol. Additionally, the `health_check` configuration determines when the Load Balancer should transition instances from healthy to unhealthy, depending on the ability to reach HTTP port 80 on the target instance.
- Autoscaling
In order to set up autoscaling, it was necessary to create a VPC. The specific networking infrastructure created was a VPC, two Public Subnets, Route Table and Internet Gateway. The autoscaling group by default launches two instances and puts each of them in a separate Availability Zone in different subnets. The ELB is responsible in sharing instance availability with the auto scaling group. Each instance launched has the name `nginx web server`. 
The autoscaling policies are responsible for changing Auto Scaling Group instances count based on cloud watch metrics. If total CPU utilization of all instances are greater than `75%` threshold for 120 seconds, another instance is added. If CPU utilization is less than `15%` for all instances, an instance is removed.

# Troubleshoot: SSH into instance
If the app is not running as expected and you want to SSH into the running instance to begin troubleshooting, here are the steps to connect to the instance:
1) Log into AWS and search for `EC2`
2) In the side bar, click on `instances`
3) Select the instance that you want to troubleshoot and click `connect`
4) Use your key pair and follow the instructions provided by AWS.


# Further Implementations
Spin up NGINX Web Server using a Containerized App instead of within the EC2 instance.

Consider using Elastic Beanstalk, ECS or Fargate to orchestrate different AWS services. 

Add Route53 DNS name

Make security groups more fine-grained based on expectations of the app
 test12