# Example on how to create a static website on AWS with Terraform

This example creates a S3 bucket with Static website enabled and set it for publically accessible.
It upload all the files from HTML folder to the bucket.
The output will be shown the website URL.

If you want to use it then update the Access key and Secret Key and then run the below commands (make sure you have Terraform Installed locally)

# terraform init
# terraform plan

# terraform apply 
 It will ask for confirmation just type "yes"
 and if you want to skip this message then use the below command instead.
 
# terraform apply --auto-approve

After testing if you want to destroy the objects then use the below command
# terraform destroy 
OR 

# terraform apply --auto-approve
