#!/bin/bash

# Get a list of all AWS regions
regions=$(aws ec2 describe-regions --output json --query 'Regions[].RegionName')

# Iterate over each region
for region in $(echo "$regions" | jq -r '.[]'); do
  echo "Checking region: $region"

  # Set the current AWS CLI region
  export AWS_DEFAULT_REGION="$region"

  # Get a list of EKS cluster names in the current region
  clusters=$(aws eks list-clusters --output json --query clusters)

  # Iterate over each cluster and delete it
  for cluster in $(echo "$clusters" | jq -r '.[]'); do
    cluster_name=$(echo "$cluster" | tr -d ',"')
    echo "Deleting EKS cluster: $cluster_name in region: $region"

    # Check if node groups are attached
    nodegroups=$(aws eks list-nodegroups --cluster-name "$cluster_name" --output json --query nodegroups)

    # If node groups are attached, proceed to delete them
    if [ "$nodegroups" != "null" ]; then
      # Iterate over each node group and delete it
      for nodegroup in $(echo "$nodegroups" | jq -r '.[]'); do
        nodegroup_name=$(echo "$nodegroup" | tr -d ',"')
        echo "Deleting node group: $nodegroup_name"
        aws eks delete-nodegroup --cluster-name "$cluster_name" --nodegroup-name "$nodegroup_name" > /dev/null 2>&1
      done
    fi

    # Delete the EKS cluster
    aws eks delete-cluster --name "$cluster_name" > /dev/null 2>&1
  done
done
