#!/bin/bash

if aws cloudformation validate-template --template-body file://pipeline.yml
then
  if aws cloudformation validate-template --template-body file://base-cfn-template.yml
  then
    zip cfn-template.zip base-cfn-template.yml test-stack-configuration.json prod-stack-configuration.json
    aws s3api put-object --bucket aws-line-movement-infrastructure --key cfn-synthesize-resources/cfn-template.zip --body cfn-template.zip
    rm cfn-template.zip
    aws s3api put-object --bucket aws-line-movement-infrastructure --key pipeline/pipeline.yml --body pipeline.yml
    # make sure to build latest version of service code with ./gradlew buildZip
    aws s3api put-object --bucket awslinemovementservice-lambda-src-code --key ServiceLambdaCode --region us-east-1 --body ../AWSLineMovementService/build/distributions/AWSLineMovementService-1.0-SNAPSHOT.zip
    aws s3 sync ../line-movement-static-website/build/ s3://aws-linemovement-static-website/
  else
    echo "CFN validation for base template failed"
  fi
else
  echo "CFN validation for pipeline failed"
fi
