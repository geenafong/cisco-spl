# ubuntu-trusty-14.04 (x64)
variable "aws_ami" {
  default = {
    "us-west-2" = "ami-7f675e4f"
  }
}

variable "key_name" {
  description = "Name of the SSH keypair to use in AWS."
}

variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-west-2"
}
