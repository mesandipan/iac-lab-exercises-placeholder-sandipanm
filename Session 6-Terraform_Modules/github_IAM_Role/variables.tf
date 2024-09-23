variable "prefix" {
  type        = string
  description = "Prefix to many of the resources created which helps as an identifier, could be company name, solution name, etc"
  default     = "tw-iac-demo"
}

variable "repo_name" {
  type        = string
  description = "Name of GitHub repository"
  default     = "mesandipan/iac-lab-exercises-placeholder-sandipanm"
}

variable "region" {
  type        = string
  description = "Region to deploy the solution"
  default     = "ap-south-1"
}
