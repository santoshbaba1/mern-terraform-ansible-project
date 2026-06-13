variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet" {
  default = "10.0.1.0/24"
}

variable "private_subnet" {
  default = "10.0.2.0/24"
}

variable "instance_type" {
  default = "t2.micro"
}
# Key pair for EC2 instance. Replace the default value with your actual key pair name.
variable "key_name" {
  default = "terraform-keypair"
}
