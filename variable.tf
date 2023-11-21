variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

# variable "instance_type" {
#   description = "Instance type for EC2 instance"
#   type        = string
# }

variable "az" {
  description = "List of availability zones"
  type        = list(string)
  default   = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "subnets" {
  description = "Map of availability zones to subnet CIDR blocks"
  type        = map(string)
  default = {
    "us-east-1a" = "10.0.1.0/24"
    "us-east-1b" = "10.0.2.0/24"
    "us-east-1c" = "10.0.3.0/24"
  }
}