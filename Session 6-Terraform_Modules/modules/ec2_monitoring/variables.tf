variable "prefix" {
  type        = string
  description = "Prefix to many of the resources created which helps as an identifier, could be company name, solution name, etc"
}

variable "instance_id" {
  type        = string
  description = "The EC2 instance Id"
}

variable "cw_log_retention_in_days" {
  type        = number
  description = "Cloudwatch log retention in days"
}
