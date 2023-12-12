#!/bin/bash

set -e

export REGION="ap-northeast-1"
# shellcheck disable=SC2155
export ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
export REPO="$ACCOUNT_ID.dkr.ecr.${REGION}.amazonaws.com"
export BYOC="$ACCOUNT_ID.dkr.ecr.${REGION}.amazonaws.com/stable-diffusion-aws-extension/aigc-webui-inference:roop"

# Login ECR for build and push your image
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin "$REPO"

# Build your image
docker build -f Dockerfile -t "$BYOC" .

# Push your image to ECR
docker push "$BYOC"
