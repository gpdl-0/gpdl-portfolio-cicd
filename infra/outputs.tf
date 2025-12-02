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
# Required for GitHub Actions OIDC configuration
output "github_oidc_role_arn" {
  description = "The ARN of the IAM Role to be assumed by GitHub Actions via OIDC."
  value       = aws_iam_role.github_actions.arn
}

output "acm_certificate_validation_records" {
  description = "CNAME records required for DNS validation on Hostinger"
  value = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  }
}