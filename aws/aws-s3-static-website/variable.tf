# Access key variable 
variable "aws-access-key" {
    default = "your_access_key"
    description = "AWS Access Key"
    sensitive=true
}

# Secret key variable 
variable "aws-secret-key" {
    default = "your_secret_key"
    description = "AWS Secret Key"
    sensitive=true
}

# Region variable
variable "aws-region" {
  default = "us-east-2"
}

variable "local_directory" {
  default = "./html/"
}