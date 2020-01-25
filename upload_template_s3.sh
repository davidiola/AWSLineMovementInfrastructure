#!/bin/bash

aws s3api put-object --bucket aws-line-movement-infrastructure --key cfn-synthesize-resources/base-cfn-template.yaml --body base-cfn-template.yaml
aws s3api put-object --bucket aws-line-movement-infrastructure --key cfn-synthesize-resources/test-stack-configuration.json --body test-stack-configuration.json
aws s3api put-object --bucket aws-line-movement-infrastructure --key cfn-synthesize-resources/prod-stack-configuration.json --body prod-stack-configuration.json

