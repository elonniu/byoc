#!/bin/bash

set -e

export REGION="ap-northeast-1"
export ENDPOINT_NAME="infer-endpoint-api-test"
# shellcheck disable=SC2155
export ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
export BYOC="$ACCOUNT_ID.dkr.ecr.${REGION}.amazonaws.com/stable-diffusion-aws-extension/aigc-webui-inference:roop"

# Update Endpoint Image
curl -s https://raw.githubusercontent.com/awslabs/stable-diffusion-aws-extension/dev/build_scripts/update_endpoint_image.sh | bash -s $REGION $ENDPOINT_NAME "$BYOC"
