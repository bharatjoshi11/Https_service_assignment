resource "aws_lambda_function" "this" {
  function_name    = var.lambda_details.name
  filename         = "../lambda-handler.zip"
  source_code_hash = filebase64sha256("../lambda-handler.zip")
  role             = aws_iam_role.this.arn
  handler          = var.lambda_details.handler
  architectures    = ["x86_64"]
  memory_size      = var.lambda_details.memory_size
  runtime          = var.lambda_details.runtime
  tags             = var.tags
  environment {
    variables = {
      BUCKET_NAME = var.bucket_name
    }
  }
}

resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/*"
}





resource "aws_iam_role" "this" {
  name = var.lambda_details.name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
  tags = var.tags
}


resource "aws_iam_role_policy" "this" {
  name = "${var.lambda_details.name}-lambda-role-policy"
  role = aws_iam_role.this.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:*"
        Resource = "${aws_s3_bucket.delivery_bucket.arn}"
      }

    ]
  })
}
