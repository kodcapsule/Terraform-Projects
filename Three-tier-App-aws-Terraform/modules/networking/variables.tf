variable "project-name" {
    description = "The name of your project"
    type = string  
}


variable "vpc-cidr-block" {
    description = "CIDR block for your VPC"
    type = string  
}

variable "availability-zones" {
    description = "List of avialablity zones for your app"
    type = list(string)
  
}
variable "public-cidr-blocks" {
    description = "List of Cidr blocks for the public subnets"
    type = list(string)  
}


variable "private-cidr-blocks" {
    description = "List of Cidr blocks for the private subnets"
    type = list(string)  
}