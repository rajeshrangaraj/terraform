variable "env" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}