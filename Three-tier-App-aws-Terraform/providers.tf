terraform {
  required_providers {
    aws={
        source = "hashicorp/aws"
        version = "~> 4.16"
    }
  }
     required_version = ">= 1.2.0"

 backend "s3" {
    bucket = "kodecapsule-state"
    key = "global/s3/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "state-lock-table"
    encrypt = true
     
   }
}





provider "aws" {
    region = var.aws-region
  
}