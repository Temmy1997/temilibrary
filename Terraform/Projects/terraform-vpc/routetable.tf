## Create the public route table 
resource "aws_route_table" "publicRT" {
  vpc_id = aws_vpc.terraformvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
    } 
    tags = {
    Name = "public-route"
  }
}

## Create the private route table 
resource "aws_route_table" "privateRT" {
  vpc_id = aws_vpc.terraformvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natGW.id
    } 
    tags = {
    Name = "private-route"
  }
}

## Create aws_route_table_association (Subnet accosation) public subnet1
resource "aws_route_table_association" "public1" {
  subnet_id = aws_subnet.publicsubnet1.id
  route_table_id = aws_route_table.publicRT.id
}

## Create aws_route_table_association (Subnet accosation) public subnet2
resource "aws_route_table_association" "public2" {
  subnet_id = aws_subnet.publicsubnet2.id
  route_table_id = aws_route_table.publicRT.id
}

## Create aws_route_table_association (Subnet accosation) Private subnet1
resource "aws_route_table_association" "private1" {
  subnet_id = aws_subnet.privatesubnet1.id
  route_table_id = aws_route_table.privateRT.id
}


## Create aws_route_table_association (Subnet accosation) Private subnet2
resource "aws_route_table_association" "private2" {
  subnet_id = aws_subnet.privatesubnet2.id
  route_table_id = aws_route_table.privateRT.id
}