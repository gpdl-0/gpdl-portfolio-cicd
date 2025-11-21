# ----------------------------------------------------
# 1. GITHUB OIDC PROVIDER CONFIGURATION
# ----------------------------------------------------
# Retrieve the TLS certificate from GitHub's OIDC endpoint to create the thumbprint
data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}

# Create the OIDC Provider in IAM to establish trust with GitHub
resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.github.certificates[0].sha1_fingerprint]
}

# ----------------------------------------------------
# 2. IAM ROLE FOR GITHUB ACTIONS
# ----------------------------------------------------
# This role will be assumed by the GitHub Actions runner during deployment
resource "aws_iam_role" "github_actions" {
  name = "github-actions-portfolio-role"

  # Trust Policy: Defines WHO can assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRoleWithWebIdentity"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Condition = {
          StringLike = {
            # SECURITY CRITICAL: Lock access to ONLY this specific repository.
            # REPLACE 'YOUR_GITHUB_USER/YOUR_REPO_NAME' below with your actual values.
            
            "token.actions.githubusercontent.com:sub": "repo:gpdl-0/gpdl-portfolio-cicd:*"
          }
          StringEquals = {
            "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

# ----------------------------------------------------
# 3. LEAST PRIVILEGE POLICY
# ----------------------------------------------------
# Permissions strictly limited to S3 Sync and CloudFront Invalidation
resource "aws_iam_policy" "ci_cd_policy" {
  name        = "portfolio-ci-cd-policy"
  description = "Minimal permissions for GitHub Actions to deploy the static site"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "S3Access"
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject",
          "s3:GetBucketLocation"
        ]
        Resource = [
          aws_s3_bucket.website_bucket.arn,
          "${aws_s3_bucket.website_bucket.arn}/*"
        ]
      },
      {
        Sid    = "CloudFrontInvalidation"
        Effect = "Allow"
        Action = [
          "cloudfront:CreateInvalidation",
          "cloudfront:GetDistribution"
        ]
        Resource = aws_cloudfront_distribution.s3_distribution.arn
      }
    ]
  })
}

# Attach the policy to the Role
resource "aws_iam_role_policy_attachment" "attach_ci_cd" {
  role       = aws_iam_role.github_actions.name
  policy_arn = aws_iam_policy.ci_cd_policy.arn
}
