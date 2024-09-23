terraform {
  backend "s3" {
    bucket         = "tw-sandipan-iac-lab-tfstate"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    profile        = "twbeach"
    dynamodb_table = "tw-sandipan-iac-lab-tfstate-lock"
    encrypt        = true
  }
}
