package main

import (
	"context"
	"fmt"
	"os"
	"strings"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/s3"
)

func HandleRequest(ctx context.Context, request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	path := request.PathParameters["path"]
	bucketName := os.Getenv("BUCKET_NAME")

	sess, _ := session.NewSession(&aws.Config{
		Region: aws.String("us-east-1"),
	})

	svc := s3.New(sess)
	var prefix string
	var delimiter string
	if path == "" {
		delimiter = "/"
	} else {
		prefix = strings.TrimPrefix(path, "/") + "/"
		delimiter = "/"
	}

	input := &s3.ListObjectsV2Input{
		Bucket:    aws.String(bucketName),
		Prefix:    aws.String(prefix),
		Delimiter: aws.String(delimiter),
	}

	result, _ := svc.ListObjectsV2WithContext(context.Background(), input)

	// collect top level data only
	fmt.Println(result)
	var contents []string
	for _, item := range result.Contents {
		contents = append(contents, strings.TrimPrefix(*item.Key, prefix))
	}
	for _, dir := range result.CommonPrefixes {
		contents = append(contents, strings.TrimPrefix(*dir.Prefix, prefix))
	}

	body := "Contents for your request "
	for _, item := range contents {
		body += item + "\n"
	}

	return events.APIGatewayProxyResponse{
		StatusCode: 200,
		Body:       body,
	}, nil
}

func main() {
	lambda.Start(HandleRequest)
}
