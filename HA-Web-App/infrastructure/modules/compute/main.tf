


resource "aws_instance" "ec2-instance" {
   ami = "ami-04b4f1a9cf54c11d0"
   instance_type = "t2.micro"
   key_name = "Ubuntu-key-pair"
   subnet_id = var.subnet-id
   associate_public_ip_address =  var.assign-public-ip 
}