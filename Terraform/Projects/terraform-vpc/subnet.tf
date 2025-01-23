## Create the public subnet AZ1 
resource "aws_subnet" "publicsubnet1" {
  vpc_id = aws_vpc.terraformvpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}

## Public Subnet in AZ2
resource "aws_subnet" "publicsubnet2" {
  vpc_id = aws_vpc.terraformvpc.id
  cidr_block = "192.168.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}
## availability_zone - AZ for the subnet.
## cidr_block - The IPv4 CIDR block for the subnet.
## vpc_id - (Required) The VPC ID.
## tags - A map of tags to assign to the resource. 
## map_public_ip_on_launch - (Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false.

## Create the private subnet1
resource "aws_subnet" "privatesubnet1" {
  vpc_id = aws_vpc.terraformvpc.id
  cidr_block = "192.168.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "private-subnet"
  }
}

## Create the private subnet2
resource "aws_subnet" "privatesubnet2" {
  vpc_id = aws_vpc.terraformvpc.id
  cidr_block = "192.168.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "private-subnet"
  }
}
## availability_zone - AZ for the subnet.
## cidr_block - The IPv4 CIDR block for the subnet.
## vpc_id - (Required) The VPC ID.
## tags - A map of tags to assign to the resource. 