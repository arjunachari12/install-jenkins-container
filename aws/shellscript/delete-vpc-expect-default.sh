Deleting all VPCs except the default VPC can be a sensitive operation as it will remove all the resources associated with those VPCs, including EC2 instances, subnets, security groups, route tables, and more. Ensure that you understand the implications and have backups or snapshots of critical data before running such a script.

Here's a script that can be used to delete all non-default VPCs across all AWS regions:

```bash
#!/bin/bash

# Get a list of all AWS regions
regions=$(aws ec2 describe-regions --output json --query 'Regions[].RegionName')

# Iterate over each region
for region in $(echo "$regions" | jq -r '.[]'); do
  echo "Checking region: $region"

  # Set the current AWS CLI region
  export AWS_DEFAULT_REGION="$region"

  # Get a list of VPC IDs in the current region (excluding the default VPC)
  vpcs=$(aws ec2 describe-vpcs --output json --query 'Vpcs[?!(IsDefault==true)].VpcId')

  # Iterate over each non-default VPC and delete it
  for vpc in $(echo "$vpcs" | jq -r '.[]'); do
    echo "Deleting VPC: $vpc in region: $region"
    
    # Detach and delete internet gateways if attached
    igws=$(aws ec2 describe-internet-gateways --filters "Name=attachment.vpc-id,Values=$vpc" --output json --query 'InternetGateways[].InternetGatewayId')
    for igw in $(echo "$igws" | jq -r '.[]'); do
      aws ec2 detach-internet-gateway --internet-gateway-id "$igw" --vpc-id "$vpc" > /dev/null 2>&1
      aws ec2 delete-internet-gateway --internet-gateway-id "$igw" > /dev/null 2>&1
    done

    # Detach and delete VPN gateways if attached
    vpns=$(aws ec2 describe-vpn-gateways --filters "Name=attachment.vpc-id,Values=$vpc" --output json --query 'VpnGateways[].VpnGatewayId')
    for vpn in $(echo "$vpns" | jq -r '.[]'); do
      aws ec2 detach-vpn-gateway --vpn-gateway-id "$vpn" --vpc-id "$vpc" > /dev/null 2>&1
      aws ec2 delete-vpn-gateway --vpn-gateway-id "$vpn" > /dev/null 2>&1
    done

    # Delete subnets
    subnets=$(aws ec2 describe-subnets --filters "Name=vpc-id,Values=$vpc" --output json --query 'Subnets[].SubnetId')
    for subnet in $(echo "$subnets" | jq -r '.[]'); do
      aws ec2 delete-subnet --subnet-id "$subnet" > /dev/null 2>&1
    done

    # Delete security groups
    security_groups=$(aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$vpc" --output json --query 'SecurityGroups[].GroupId')
    for security_group in $(echo "$security_groups" | jq -r '.[]'); do
      aws ec2 delete-security-group --group-id "$security_group" > /dev/null 2>&1
    done

    # Delete route tables
    route_tables=$(aws ec2 describe-route-tables --filters "Name=vpc-id,Values=$vpc" --output json --query 'RouteTables[].RouteTableId')
    for route_table in $(echo "$route_tables" | jq -r '.[]'); do
      aws ec2 delete-route-table --route-table-id "$route_table" > /dev/null 2>&1
    done

    # Delete VPC
    aws ec2 delete-vpc --vpc-id "$vpc" > /dev/null 2>&1
  done
done
```

This script does the following for each non-default VPC:

- Detaches and deletes internet gateways if attached.
- Detaches and deletes VPN gateways if attached.
- Deletes subnets.
- Deletes security groups.
- Deletes route tables.
- Deletes the VPC itself.

Please exercise caution when running this script and ensure that you have appropriate backups or snapshots before proceeding. Additionally, ensure that your AWS CLI configuration has the necessary permissions to describe and delete resources in all regions.
