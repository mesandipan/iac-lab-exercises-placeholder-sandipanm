resource "aws_dynamodb_table" "tfstate_lock" {
  name         = var.my_dynamoDB
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = format("%s-vpc", var.prefix)
  }
}
