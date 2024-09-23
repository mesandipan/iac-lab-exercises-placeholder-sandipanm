variable "prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "myproject"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
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
