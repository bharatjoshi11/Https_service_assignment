variable "region" {
  type = string
  default = "us-east-1"
}

variable "tags" {
  type = map(any)
  default = {
    Project = "ONE2N"
  }
}

#s3

variable "bucket_name" {
  type = string
}

variable "force_destroy" {
  type = bool
  default = true
}



#lamda  
variable "lambda_details" {
  type = map(any)
}

#api
variable "apiname" {
  type = string
  default = "one2n_api"
}

variable "stage_name" {
  type = string
  default = "list-bucket-content"
}

variable "http_method_type" {
  type = string
  default = "GET"
}