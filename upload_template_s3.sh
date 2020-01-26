#!/bin/bash

if aws cloudformation validate-template --template-body file://base-cfn-template.yaml
then
  zip cfn-template.zip base-cfn-template.yaml test-stack-configuration.json prod-stack-configuration.json
  aws s3api put-object --bucket aws-line-movement-infrastructure --key cfn-synthesize-resources/cfn-template.zip --body cfn-template.zip
  aws s3api put-object --bucket aws-line-movement-infrastructure --key pipeline/pipeline.yml --body pipeline.yml
  rm cfn-template.zip
else
  echo "CFN Validation failed"
fi

