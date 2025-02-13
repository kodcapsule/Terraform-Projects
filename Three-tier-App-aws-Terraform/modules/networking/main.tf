

resource "aws_vpc" "main-vpc" {
    cidr_block = var.vpc-cidr-block
    instance_tenancy = default
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
      name ="${var.project-name}"
    }
  
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main-vpc.id
  tags = {
      name ="${var.project-name}-igw"
    }
  
}

resource "aws_subnet" "public-subnets" {
  count = length(var.public-cidr-blocks)
  vpc_id = aws_vpc.main-vpc.id
  cidr_block = var.public-cidr-blocks[count.index]
  map_public_ip_on_launch = true
  availability_zone = element(var.availability-zones,count.index)

  tags = {
    name= "${var.project-name}-public-subnet-${count.index}"
  }
  
}

resource "aws_subnet" "private-subnets" {
  count = length(var.private-cidr-blocks)
  vpc_id = aws_vpc.main-vpc.id
  cidr_block = var.private-cidr-blocks[count.index]
  availability_zone = element(var.availability-zones,count.index)

  tags = {
    name= "${var.project-name}-private-subnet-${count.index}"
  }
  
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main-vpc.id

   tags = {
      name ="${var.project-name}-public-rt"
    }
  }


resource "aws_route" "public-internet-route" {
   route_table_id = aws_route_table.public-rt.id
   destination_cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.igw.id


}

resource "aws_route_table_association" "public" {
  count = length(var.private-cidr-blocks)
  subnet_id = aws_subnet.public-subnets[count.index].id
  route_table_id = aws_route_table.public-rt.id
  }