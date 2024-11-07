resource "aws_s3_bucket" "delivery_bucket" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy
  tags          = var.tags
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.delivery_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "lambda_upload_policy_for_content_bucket" {
  bucket     = aws_s3_bucket.delivery_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "s3:GetObject"
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.delivery_bucket.arn}/*"
        Principal = {
          AWS = "${aws_iam_role.this.arn}"
        }
      }
    ]
  })
}
