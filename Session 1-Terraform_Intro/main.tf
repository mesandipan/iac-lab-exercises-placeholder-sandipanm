// Session 1 - IaC and Terraform Intro
// To create an AWS VPC

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = "twbeach"
}

variable "prefix" {
  type        = string
  description = "Prefix to many of the resources created which helps as an identifier, could be company name, solution name, etc"
  default     = "tw-iac-intro-sandipan"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
  default     = "192.168.0.0/25"
}

variable "region" {
  type        = string
  description = "Region to deploy the solution"
  default     = "ap-south-1"
}

resource "random_pet" "this" {
  length = 1
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  instance_tenancy     = "default"

  tags = {
    //Name = "iac-lab-placeholder:sandipanm"
    Name = format("%s-%s-vpc", var.prefix, random_pet.this.id)
  }
}

variable "subnet1_cidr" {
  type        = string
  description = "Subnet 1 CIDR block"
  default     = "192.168.0.0/26"
}

variable "subnet2_cidr" {
  type        = string
  description = "Subnet 1 CIDR block"
  default     = "192.168.0.64/26"
}

variable "subnet3_cidr" {
  type        = string
  description = "Subnet 1 CIDR block"
  default     = "192.168.0.128/26"
}

variable "subnet4_cidr" {
  type        = string
  description = "Subnet 1 CIDR block"
  default     = "192.168.0.192/26"
}