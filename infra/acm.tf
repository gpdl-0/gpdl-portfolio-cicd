# ----------------------------------------------------
# 1. SSL CERTIFICATE REQUEST
# ----------------------------------------------------
# Requests a public certificate from AWS Certificate Manager (ACM)
# MUST be in us-east-1 for CloudFront usage.
resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  # Add Subject Alternative Names (SANs) for 'www' subdomain
  subject_alternative_names = [
    "www.${var.domain_name}"
  ]

  tags = {
    Environment = "Production"
    Project     = "Portfolio"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# ----------------------------------------------------
# 2. CERTIFICATE VALIDATION (DNS) - NEED IMPROVEMENT
# ----------------------------------------------------
# This resource is used to wait for validation to complete.
# Note: Since DNS is hosted on Hostinger (external), Terraform will wait
# until you manually add the CNAME records provided in the output.
# Only then will this resource finish creation.
# resource "aws_acm_certificate_validation" "cert_validation" {
#   certificate_arn         = aws_acm_certificate.cert.arn
#   validation_record_fqdns = [for r in aws_acm_certificate.cert.domain_validation_options : r.resource_record_name]
# }
# NOTE: Commented out to prevent Terraform from freezing indefinitely 
# while waiting for manual action. We will handle validation manually first.