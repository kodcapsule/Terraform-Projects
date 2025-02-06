output "public-subnet-id" {
    description = "The Id for the public subnet"
    value = aws_subnet.public-subnet.id  
}


output "private-subnet-id" {

     description = "The Id for the private subnet"
    value = aws_subnet.private-subnet.id 
  
}
output "vpc-id" {
    description = "The VPC Id"
    value = aws_vpc.kodecapsule-vpc.id
  
}