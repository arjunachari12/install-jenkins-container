#!/bin/bash

# Get a list of all AWS regions
regions=$(aws ec2 describe-regions --output json --query 'Regions[].RegionName')

# Iterate over each region
for region in $(echo "$regions" | jq -r '.[]'); do
  echo "Checking region: $region"

  # Set the current AWS CLI region
  export AWS_DEFAULT_REGION="$region"

  # Get a list of Elastic IPs in the current region
  eips=$(aws ec2 describe-addresses --output json --query 'Addresses[].AllocationId')

  # Iterate over each Elastic IP and release it
  for eip in $(echo "$eips" | jq -r '.[]'); do
    echo "Releasing Elastic IP: $eip in region: $region"
    aws ec2 release-address --allocation-id "$eip" > /dev/null 2>&1
  done
done
