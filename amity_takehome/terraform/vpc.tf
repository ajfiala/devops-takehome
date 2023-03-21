# VPC and subnets for the application

# elastic IP for NAT Gateway
resource "aws_eip" "one" {
  vpc = true

}

# VPC which will contain all of the infrastructure for our application
resource "aws_vpc" "molecular_app" {
  cidr_block = "10.0.0.0/16"
}


resource "aws_subnet" "ap_public_1" {
  vpc_id            = aws_vpc.molecular_app.id
  availability_zone = "ap-southeast-1a"
  cidr_block        = "10.0.1.0/24"
}

resource "aws_subnet" "ap_private_1" {
  vpc_id            = aws_vpc.molecular_app.id
  availability_zone = "ap-southeast-1b"
  cidr_block        = "10.0.2.0/24"
}

# gateway that allows access to the internet from the public subnet

resource "aws_internet_gateway" "molecular_app_gw" {
  vpc_id = aws_vpc.molecular_app.id


}

# NAT Gateway. This allows EC2 instances in the private subnet to access the internet
resource "aws_nat_gateway" "example" {

  allocation_id     = aws_eip.one.id
  connectivity_type = "public"
  subnet_id         = aws_subnet.ap_public_1.id
}


# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.molecular_app.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.molecular_app_gw.id
  }

  tags = {
    Name = "public"
  }
}

# Associate Public Route Table with Public Subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.ap_public_1.id
  route_table_id = aws_route_table.public.id
}


# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.molecular_app.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.example.id
  }

  tags = {
    Name = "private"
  }
}

# Associate Private Route Table with Private Subnet
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.ap_private_1.id
  route_table_id = aws_route_table.private.id
}
