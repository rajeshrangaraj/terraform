variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

# variable "subnet_id" {
#     type = string
# }

# variable "vpc_id" {
#     type = string
# }

variable "key_name" {
  type    = string
  default = null
}

variable "user_data" {
  type    = string
  default = null
}

variable "root_volume_size" {
  type    = number
  default = 20
}

variable "extra_sg_ids" {
  type    = list(string)
  default = []
}

variable "iam_policies" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}