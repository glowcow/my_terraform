variable "ec2_name" {
  description = "Name of the AWS EC2"
  type        = string
  default     = "chr-aws"
}
variable "instance_type" {
  description = "CPU and RAM of the AWS EC2"
  type        = string
  default     = "t2.micro"
}
variable "ami_image" {
  description = "AMI images id eu-west-2 CHR"
  type        = string
  default     = "ami-0fd8446e67541a72e"
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