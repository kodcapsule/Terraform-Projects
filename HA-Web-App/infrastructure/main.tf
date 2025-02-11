terraform {
  required_providers {
    aws={
        source = "hashicorp/aws"
        version = "~> 4.16"
    }
  }
   required_version = ">= 1.2.0"

  #  backend "s3" {
  #   bucket = "kodecapsule-state"
  #   key = "global/s3/terraform.tfstate"
  #   region = "us-east-1"
  #   dynamodb_table = "state-lock-table"
  #   encrypt = true
     
  #  }
}


provider "aws" {
    region = "us-east-1"  
}


# ======================== CONFIGURE REMOTE BACKEND =========================

resource "aws_s3_bucket" "state-bucket" {
    bucket = "kodecapsule-state"
    # lifecycle {
    #   prevent_destroy = true
    # }     
}

resource "aws_s3_bucket_versioning" "state-version" {
    bucket = aws_s3_bucket.state-bucket.id 
    versioning_configuration {
      status = "Enabled"
  }
  
}



resource "aws_s3_bucket_server_side_encryption_configuration" "bucket-encryption" {
    bucket = aws_s3_bucket.state-bucket.id

    rule {
        apply_server_side_encryption_by_default {
           sse_algorithm     = "AES256"
        }    
    }
}

resource "aws_s3_bucket_public_access_block" "sublic-access" {
    bucket = aws_s3_bucket.state-bucket.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true

}


resource "aws_dynamodb_table" "terrafor-state-lock" {
    name = "state-lock-table"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
  
  attribute {
    name = "LockID"
    type = "S"
  }
}


# ======================== CONFIGURE VPC =========================

module "kodecapsule-vpc" {
  source = "./modules/VPC"
  
}

module "kodecapsule-webserve" {
  source = "./modules/compute"
  subnet-id = module.kodecapsule-vpc.public-subnet-id
  assign-public-ip = true
  
}


module "kodecapsule-webserve-1" {
  source = "./modules/compute"
  subnet-id = module.kodecapsule-vpc.private-subnet-id  
}