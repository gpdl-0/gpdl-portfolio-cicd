# ----------------------------------------------------
# 1. ORIGIN ACCESS CONTROL (OAC)
# ----------------------------------------------------
resource "aws_cloudfront_origin_access_control" "default" {
  name                              = "cloudfront-oac-${var.domain_name}"
  description                       = "OAC to access restricted S3 bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# ----------------------------------------------------
# 2. CLOUDFRONT DISTRIBUTION
# ----------------------------------------------------
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.website_bucket.bucket_regional_domain_name
    origin_id                = "S3-${var.domain_name}"
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  comment             = "Cloud Engineer Portfolio CDN"

  # COST OPTIMIZATION: Only use NA and EU edge locations (sufficient for portfolio traffic)
  # Change to "PriceClass_All" if you need lowest latency globally.
  price_class = "PriceClass_100" 

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${var.domain_name}"

    # Minimal cache logic: forward no query strings or cookies
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https" # CRITICAL: Forces HTTPS
    min_ttl                = 0
    default_ttl            = 7200  # 2 hour cache
    max_ttl                = 86400 # 24 hours max cache
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # For now, we use the default CloudFront SSL cert (*.cloudfront.net)
  # We will change this in Sprint 4 to use the custom domain certificate (ACM)
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}