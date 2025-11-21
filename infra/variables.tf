variable "aws_region" {
  description = "AWS region for resource creation"
  default     = "us-east-1"
}

variable "domain_name" {
  description = "The unique bucket/domain name for the static website"
  type        = string
  default     = "gpdlportfolio.shop" 
}
