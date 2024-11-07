bucket_name = "s3bucketdonotdel"

lambda_details = {
  name                       = "code_process_lambda"
  handler                    = "index.handler"
  memory_size                = "256"
  runtime                    = "provided.al2023"
}

apiname = "one2n_api"

stage_name = "list-bucket-content"

http_method_type = "GET"