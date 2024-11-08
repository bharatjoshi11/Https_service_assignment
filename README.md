# Https_Service_assignment

Configuration in this directory creates Golang code to get data from a s3 bucket specific directory and also created AWS infra to deploy this appplication

## Usage

To run this Application you need to execute:

# Build for lambda code

These steps will create a build of lambda code in your windows environment , we can also build the code build using CI/CD pipeline.


1. $env:GOOS = "linux"
2. $env:GOARCH = "amd64"
3. $env:CGO_ENABLED = "0"
4. go mod init
5. go mod tidy
7. go build -o Handler main.go
8. ~\Go\Bin\build-lambda-zip.exe -o lambda-handler.zip Handler

## Infra creation using terraform


1. cd terraform-code
2. terraform init
3. terraform plan.
4. terraform apply -auto-approve.

##Design

--> As per my task I have written the code in golang to fetch data from s3 bucket as per request path , here the design is a serverless architecture which consist api gateway for https api , lambda function to process the code and s3 bucket from where we have to fetch the data.

--> User hits the api as per his path request , api gateway has a proxy setup which handles the path structure ex. https://api/{path+} , lambda code takes the path from api and process the code to fetch data from s3.

![one2n_architecture](https://github.com/user-attachments/assets/d0b28e8b-ae97-47a4-89c7-a19b2b5b446b)


![one2n_s3](https://github.com/user-attachments/assets/c212c67f-00e2-4ddf-81fd-6efd72f2474e)




##Assumption

--> I have assumed that if we use a lambda instead of some managed compute engine we can save the cost . 

--> for https service i have used api gateway.

--> For deployment currently I am doing it locally , as no CI/CD task is mentioned.


## Working

-> In this repo we are creating a serverless application using AWS Apigateway , s3 bucket and Lambda functions . Using api gateway endpoint we are triggering lambda function which have a golang code to use AWS SDK and list all the content inside our bucket according to the api path.

-> Terraform module creating lambda , apigateway , s3 bucket , Iam role for lambda and policies for bucket

![one2n_dir2](https://github.com/user-attachments/assets/5a3801f7-7487-42fb-b5dd-d33517600851)
![on2n_root_ss](https://github.com/user-attachments/assets/1a8a3920-a809-44a5-b271-e8545293ab8c)
![on2n_dir](https://github.com/user-attachments/assets/cf69b0c4-cfd4-4156-acef-c9a880fe815f)


##Demo video



https://github.com/user-attachments/assets/b5e288bb-a18c-43d4-9288-2cb22c7e04a9




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
