variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}
variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string 
}

variable "subnets" {
  description = "Map of availability zones to subnet CIDR blocks"
  type        = map(string)
}