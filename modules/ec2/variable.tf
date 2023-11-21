variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
  
}

variable "ami_id" {
  description = "List of subnet IDs"
  type        = string
}
variable "security_group_ids" {
  description = "ID of the security group"
  type        = list(string)
}