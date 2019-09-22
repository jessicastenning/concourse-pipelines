#!/bin/bash

set -euo pipefail

buckets="$(aws s3 ls)"


if [[ $buckets == *"${BUCKET_NAME}"* ]]; then
  echo "Existing bucket found for project ${BUCKET_NAME}"

  if aws s3 ls "s3://${BUCKET_NAME}/ci/terraform.tfstate"; then
    aws s3 cp "s3://${BUCKET_NAME}/ci/terraform.tfstate" terraform.tfstate
  else
    echo "Error - project bucket exists, but ci/terraform.tfstate does not"
    exit 1
  fi
else
  echo "No existing bucket found for project ${BUCKET_NAME}, assuming first run"
fi

pushd git-repo/tfstate_bucket/
  terraform init

  terraform apply \
  -auto-approve \
  -input=false \
  -state=../../terraform.tfstate \
  -state-out=../../tfstate-out/terraform.tfstate
popd