variable "prefix" {
  type        = string
  description = "Prefix to many of the resources created which helps as an identifier, could be company name, solution name, etc"
}

variable "region" {
  type        = string
  description = "Region to deploy the solution"
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block" // Classless Inter-Domain Routing (CIDR) is an IP address allocation method that improves data routing efficiency on the internet.
}

variable "number_of_public_subnets" {
  description = "The number of public subnets to create."
  type        = number
  default     = 2
}

variable "number_of_private_subnets" {
  description = "The number of private subnets to create."
  type        = number
  default     = 2
}

variable "number_of_secure_subnets" {
  description = "The number of secure subnets to create."
  type        = number
  default     = 2
}
