# Https_Service_assignment

Configuration in this directory creates Golang code to get data from a s3 bucket specific directory and also created AWS infra to deploy this appplication

## Usage

To run this Application you need to execute:

```bash
# Build for lambda code

These steps will create a build of lambda code in your windows environment , we can also build the code build using CI/CD pipeline.


1. $env:GOOS = "linux"

2. $env:GOARCH = "amd64"

3. $env:CGO_ENABLED = "0"

4. go build -o Handler main.go

5. ~\Go\Bin\build-lambda-zip.exe -o lambda-handler.zip Handler

## Infra creation using terraform


1. cd terraform-code
2. terraform init
3. terraform plan.
4. terraform apply -auto-approve.

##Design

--> As per my task I have written the code in golang to fetch data from s3 bucket as per request path , here the design is a serverless architecture which consist api gateway for https api , lambda function to process the code and s3 bucket from where we have to fetch the data.

--> User hits the api as per his path request , api gateway has a proxy setup which handles the path structure ex. https://api/{path+} , lambda code takes the path from api and process the code to fetch data from s3.

(https://github.com/bharatjoshi11/Https_service_assignment/blob/main/one2n_architecture.png?raw=true)


##Assumption

--> I have assumed that if we use a lambda instead of some managed compute engine we can save the cost . 

--> for https service i have used api gateway.

--> For deployment currently I am doing it locally , as no CI/CD task is mentioned.


## Working

-> In this repo we are creating a serverless application using AWS Apigateway , s3 bucket and Lambda functions . Using api gateway endpoint we are triggering lambda function which have a golang code to use AWS SDK and list all the content inside our bucket according to the api path.

-> Terraform module creating lambda , apigateway , s3 bucket , Iam role for lambda and policies for bucket



```

## Api endpoint

| Name                                               | Source                                                     |
| -------------------------------------------------- | ---------------------------------------------------------- |
| <a name="AWS Api-endpoint"></a> [AWS Api-endpoint] | https://github.com/cloudeq-EMU-ORG/ceq_tf_template_aws_acm |

## Resources

| Name                     | Type     |
| ------------------------ | -------- |
| aws_api_gateway_rest_api | resource |
| aws_lambda_function      | resource |
| aws_s3_bucket            | resource |
