

# ============ VPC =====================================
resource "aws_vpc" "kodecapsule-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "kodecapsule"
  }
}



# ============ SUBNETS =====================================

resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.kodecapsule-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

   tags = {
    Name = "kodecapsule-public-subnet"
  }
}

resource "aws_subnet" "private-subnet" {
    vpc_id = aws_vpc.kodecapsule-vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"

     tags = {
    Name = "kodecapsule-public-subnet"
  }
  
}


# ============ ROUTE TABLE & IGW=====================================

resource "aws_internet_gateway" "kodecapsule-igw" {

    vpc_id = aws_vpc.kodecapsule-vpc.id

      tags = {
    Name = "kodecapsule-igw"
  }

  
}

resource "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.kodecapsule-vpc.id

    route  {
        cidr_block="0.0.0.0/0"
        gateway_id = aws_internet_gateway.kodecapsule-igw.id
    }
}

resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.public-rt.id
  subnet_id = aws_subnet.public-subnet.id
}