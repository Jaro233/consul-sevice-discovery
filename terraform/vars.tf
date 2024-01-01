variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "region" {
  type        = string
  description = "The project region"
  default     = "us-east-1"
}

variable "ami" {
  type        = string
  description = "The amazon machine image"
  default     = "ami-0c7217cdde317cfec"
}

variable "key_name" {
  type        = string
  description = "Key Name"
  default     = "ec2_apache"
}
