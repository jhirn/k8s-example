# Commented out because bootstraping the bucket is clunky.

# resource "aws_s3_bucket" "terraform_state" {
#   bucket = "jhirn-liatrio-exercise-tf-state"

#   lifecycle {
#     prevent_destroy = false # false for demo cleanup
#   }
# }

# resource "aws_s3_bucket_versioning" "terraform_state" {
#   bucket = aws_s3_bucket.terraform_state.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
#   bucket = aws_s3_bucket.terraform_state.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }
