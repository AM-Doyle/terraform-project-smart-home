
resource "aws_dynamodb_table" "tp-dynamo-table" {
  name           = var.table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = var.hash_key

  attribute {
    name = var.hash_key
    type = var.hash_key_type
  }

  tags = {
    Name        = "tp-dynamo-table-${var.table_name}"
  }
}