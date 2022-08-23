terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Access key variable 
variable "aws-access-key" {
  default = "your_access_key"
}

# Secret key variable 
variable "aws-secret-key" {
  default = "your_secret_key"
}

# Region variable
variable "aws-region" {
  default = "us-east-2"
}

variable "local_directory" {
  default = "./html/"
}

# provider with access key
provider "aws" {
  access_key 	= "${var.aws-access-key}"
  secret_key 	= "${var.aws-secret-key}"
  region 		  = "${var.aws-region}"
}


# mime types
locals {
  mime_types = {
    htm   	= "text/html"
    html  	= "text/html"
    css   	= "text/css"
    ttf   	= "font/ttf"
    js    	= "application/javascript"
    map   	= "application/javascript"
    json  	= "application/json"
	  jpg   	= "image/jpeg"
	  jpeg   	= "image/jpeg"
	  png		  = "image/png"
  }
}

# name of the bucket
resource "aws_s3_bucket" "site-bucket" {
  bucket        = "static-website-${random_string.data.result}"
  tags = {
    Name        = "My Bucket"
    Environment = "Dev"
  }
}

# add website configuration like index.html and error.html
resource "aws_s3_bucket_website_configuration" "staticWebsite" {
  bucket = aws_s3_bucket.site-bucket.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
 }

# Allow directory to publically accesible 
resource "aws_s3_bucket_acl" "websiteAcl" {
  bucket = aws_s3_bucket.site-bucket.id
  acl    = "public-read"
}

# add policy to get all the objects
resource "aws_s3_bucket_policy" "websitePolicy" {
  bucket = aws_s3_bucket.site-bucket.id
  policy = <<EOF
  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Effect": "Allow",
              "Principal": "*",
              "Action": [
                  "s3:GetObject"
              ],
              "Resource": "arn:aws:s3:::${aws_s3_bucket.site-bucket.id}/*"
          }
      ]
  }
  EOF
}

# upload multiple files from the local directory
resource "aws_s3_bucket_object" "website_files" {
  for_each      = fileset("${var.local_directory}", "**")
  bucket        = aws_s3_bucket.site-bucket.id
  key           = each.value
  source        = "${var.local_directory}${each.value}"
  acl           = "public-read"
  etag          = filemd5("${var.local_directory}${each.value}")
  content_type  = lookup(local.mime_types, split(".", each.value)[length(split(".", each.value)) - 1])
}

# Random string
resource "random_string" "data"{
	length  = 7
	special = false
	upper 	= false
}