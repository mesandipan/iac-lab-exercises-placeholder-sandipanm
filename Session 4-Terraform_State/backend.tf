terraform {
  backend "s3" {
    bucket                   = "tw-sandipan-iac-lab-tfstate"
    key                      = "terraform.state"
    region                   = "ap-south-1"
    profile                  = "twbeach"
    dynamodb_table           = "tw-sandipan-iac-lab-tfstate-lock"
    encrypt                  = true
  }
}
resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-terraform-state-bucket"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "terraform-state-bucket"
  }
}
