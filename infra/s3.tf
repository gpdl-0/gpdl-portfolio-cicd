# ----------------------------------------------------
# 1. S3 BUCKET AND PUBLIC ACCESS BLOCK
# ----------------------------------------------------
resource "aws_s3_bucket" "website_bucket" {
  bucket = var.domain_name
}

# CRITICAL: Security best practice to prevent public access.
# The bucket is private, access will be granted only via CloudFront OAC.
resource "aws_s3_bucket_public_access_block" "website_bucket_access" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ----------------------------------------------------
# 2. IAM POLICY FOR CLOUDFRONT OAC
# ----------------------------------------------------
# This policy grants access ONLY to the CloudFront distribution.
resource "aws_s3_bucket_policy" "allow_cloudfront" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = data.aws_iam_policy_document.cloudfront_oac_access.json
}

data "aws_iam_policy_document" "cloudfront_oac_access" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.website_bucket.arn}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.s3_distribution.arn]
    }
  }
}