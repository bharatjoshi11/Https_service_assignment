resource "aws_api_gateway_rest_api" "this" {
  name        = "${var.apiname}"
  description = "API to provide data as per path request"
  tags        = var.tags
}

resource "aws_api_gateway_resource" "proxypath" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "{path+}"
}

resource "aws_api_gateway_method" "rootpath" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_rest_api.this.root_resource_id
  http_method   = var.http_method_type
  authorization = "NONE"
}
resource "aws_api_gateway_method" "proxypath_method" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.proxypath.id
  http_method   = var.http_method_type
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "root-path-integration" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_rest_api.this.root_resource_id
  http_method             = aws_api_gateway_method.rootpath.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.this.invoke_arn
}
resource "aws_api_gateway_integration" "proxy-path-integration" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.proxypath.id
  http_method             = aws_api_gateway_method.proxypath_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.this.invoke_arn
}

resource "aws_api_gateway_deployment" "this" {
  depends_on  = [ aws_api_gateway_integration.proxy-path-integration]
  rest_api_id = aws_api_gateway_rest_api.this.id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "this" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = var.stage_name
}

