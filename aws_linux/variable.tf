variable "pvt_key" {
  description = "SSH private key to access EC2"
  type        = string
  default     = "~/.ssh/id_ed25519"
}
variable "ec2_name" {
  description = "Name of the AWS EC2"
  type        = string
  default     = "linux-aws"
}
variable "instance_type" {
  description = "CPU and RAM of the AWS EC2"
  type        = string
  default     = "t2.micro"
}
variable "ami_image" {
  description = "AMI images id Ubuntu 22.04 (eu-west-2)"
  type        = string
  default     = "ami-0bde1ad52d89b8d1a"
}
variable "ec2_count" {
  description = "Count of the AWS EC2"
  type        = number
  default     = 1
}
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}
variable "aws_prv_subnet" {
  description = "AWS region"
  type        = string
  default     = "172.16.16.0/25"
}
variable "aws_vpc_subnet" {
  description = "AWS region"
  type        = string
  default     = "172.16.16.0/24"
}
variable "availability_zones" {
  description = "Availability zones"
  type        = string
  default     = "eu-west-2c"
}
