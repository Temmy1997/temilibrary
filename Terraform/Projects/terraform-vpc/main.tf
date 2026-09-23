provider "aws" {
  region = "us-east-1" 
}

## Create the VPC
 
resource "aws_vpc" "terraformvpc" {
  cidr_block = "192.168.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "terraform-vpc"
  }
}

## cidr_block - The IPv4 CIDR block for the VPC. 
## enable_dns_support - A boolean flag to enable/disable DNS support in the VPC. Defaults to true.
## enable_dns_hostnames - A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false.
## tags -  A map of tags to assign to the resource.


## Step 4: Create an internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.terraformvpc.id
  tags = {
    Name = "terraform-igw"
  }
}

## vpc_id - The VPC ID to create in. 
## tags - A map of tags to assign to the resource.


## Create an Elastic IP that is allocated and associated with the NAT gateway.
resource "aws_eip" "nat" {
  domain   = "vpc"
  tags = {
    Name = "nat-eip"
  }
}
## Create a natgateway
resource "aws_nat_gateway" "natGW" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.publicsubnet1.id
  tags = {
    Name = "nat-gateway"
  }
}

## An Elastic IP is allocated and associated with the NAT gateway.

