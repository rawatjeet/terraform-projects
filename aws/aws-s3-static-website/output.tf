output "AWS-Bucket-Name" {
	description = "S3 website URL"
	value = "http://${aws_s3_bucket.site-bucket.bucket}.s3.us-east-2.amazonaws.com"
}