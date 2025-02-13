output "vpc-id" {
    value = aws_vpc.main-vpc.id
    description = "The main VPC id"
  
}

output "public-subnets" {
    description = "The ids of the public subnets"
    value = aws_subnet.public-subnets.id
  
}


output "private-subnets" {
    description = "The ids of the private subnets"
    value = aws_subnet.private-subnets.id
  
}


output "nat-gtw-id" {
    description = "NAT gateway Id"
    value = aws_nat_gateway.nat.id  
}