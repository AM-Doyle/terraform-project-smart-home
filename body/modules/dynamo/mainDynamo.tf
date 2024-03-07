
resource "aws_dynamodb_table" "tp-dynamo-table" {

  count = length(var.table_names)

  name         = var.table_names[count.index]
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.hash_keys[count.index]

  attribute {
    name = var.hash_keys[count.index]
    type = var.hash_key_types[count.index]
  }

  tags = {
    Name = "tp-dynamo-table-${var.table_names[count.index]}"
  }
}