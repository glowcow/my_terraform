variable "do_token" {
  description = "Token to access DO API"
  type        = string
}
variable "pvt_key" {
  description = "SSH private key to access droplet"
  type        = string
  default     = "~/key/do_key"
}
variable "drplt_name" {
  description = "Name of the DO droplet"
  type        = string
  default     = "docker-do"
}
variable "drplt_size" {
  description = "CPU and RAM of the DO droplet"
  type        = string
  default     = "s-2vcpu-2gb"
}
variable "drplt_image" {
  description = "images slug of the DO droplet"
  type        = string
  default     = "docker-18-04"
}
variable "vpc_cidr" {
  description = "VPC network"
  type        = string
  default     = "10.10.10.0/24"
}
variable "do_region" {
  description = "DO region"
  type        = string
  default     = "fra1"
}

