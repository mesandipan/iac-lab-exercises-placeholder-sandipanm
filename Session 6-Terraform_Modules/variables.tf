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

variable "my_s3_bucket" {
  description = "The number of S3 Bucket to create."
  type        = string
  default     = "tw-sandipan-iac-lab-tfstate"
}

variable "my_dynamoDB" {
  description = "The number of dynamodb to create."
  type        = string
  default     = "tw-sandipan-iac-lab-tfstate-lock"
}

variable "instance_type" {
  type        = string
  description = "The EC2 instance type for the ASG"
}

variable "asg_desired_capacity" {
  type        = string
  description = "The desired capacity for the ASG"
}

variable "asg_min_size" {
  type        = string
  description = "The minimum size for the ASG"
}

variable "asg_max_size" {
  type        = string
  description = "The maximum size for the ASG"
}

variable "asg_enable_spot_instances" {
  type        = bool
  description = "Boolean to select spot instances or on demand instances"
}

variable "cw_log_retention_in_days" {
  type        = number
  description = "Cloudwatch log retention in days"
}

variable "my_public_ip_address" {
  type        = string
  description = "My public IP address to allow access to the website"
}

variable "subnets" {
  type = list(any)
}

variable "db_username" {
  type        = string
  description = "Database username"
}

variable "db_name" {
  type        = string
  description = "Database name"
}

variable "db_username" {
  type        = string
  description = "Database username"
}

variable "db_name" {
  type        = string
  description = "Database name"
}