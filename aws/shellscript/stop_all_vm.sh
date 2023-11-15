#!/bin/bash

# Get a list of all AWS regions
regions=$(aws ec2 describe-regions --output json --query 'Regions[].RegionName')

# Iterate over each region
for region in $(echo "$regions" | jq -r '.[]'); do
  echo "Checking region: $region"

  # Set the current AWS CLI region
  export AWS_DEFAULT_REGION="$region"

  # Get a list of running EC2 instances in the current region
  instances=$(aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --output json --query 'Reservations[].Instances[].InstanceId')

  # Iterate over each running EC2 instance and stop it
  for instance in $(echo "$instances" | jq -r '.[]'); do
    echo "Stopping EC2 instance: $instance in region: $region"
    aws ec2 stop-instances --instance-ids "$instance" > /dev/null 2>&1
  done
done
