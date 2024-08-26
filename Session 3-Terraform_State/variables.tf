variable "prefix" {
  type        = string
  description = "Prefix to many of the resources created which helps as an identifier, could be company name, solution name, etc"
}

variable "region" {
  type        = string
  description = "Region to deploy the solution"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block" // Classless Inter-Domain Routing (CIDR) is an IP address allocation method that improves data routing efficiency on the internet.
}

variable "subnet1_cidr" {
  type        = string
  description = "Subnet 1 CIDR block"
}

variable "subnet2_cidr" {
  type        = string
  description = "Subnet 2 CIDR block"
}

variable "subnet3_cidr" {
  type        = string
  description = "Subnet 3 CIDR block"
}

variable "subnet4_cidr" {
  type        = string
  description = "Subnet 4 CIDR block"
}
