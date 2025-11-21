output "bucket_name" {
  description = "The name of the S3 bucket."
  value       = aws_s3_bucket.website_bucket.id
}

output "cloudfront_domain_name" {
  description = "The CloudFront distribution URL (e.g., d123xyz.cloudfront.net)."
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "distribution_id" {
  description = "The ID of the CloudFront distribution for cache invalidation."
  value       = aws_cloudfront_distribution.s3_distribution.id
}