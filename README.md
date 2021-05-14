# aws-s3-hosted-website
Terraform scripts to build an AWS S3-hosted static website

## Description
These scripts build an AWS S3-hosted static website with the following components:

1. Two S3 buckets configured as websites, one named the same as the root domain name, the other with a www. prefix that redirects to the root domain name over HTTPS
2. Two AWS CloudFront distributions, one fronting each S3 bucket
3. Two Route 53 aliases, one for the root domain and one for the www. prefix, each pointing to the respective CDN
4. An ACM certificate for HTTPS

## Inputs

```hcl
variable "root_domain_name" {
  description = "The root domain name for this website. The www. subdomain will redirect to this"
  type        = string
}

variable "region" {
  description = "The AWS region this website will be created in (e.g. eu-west-2)"
  type        = string
}

variable "pages" {
  description = "Names of the Index and Error pages to use"
  type        = map(any)
  default = {
    index = "index.html"
    error = "404.html"
  }
}

variable "access_logging" {
  description = "Enable logging for the website"
  type        = bool
  default     = false
}

variable "logging_bucket" {
  description = "Name and prefix for website logging bucket"
  type        = map(any)
  default = {
    bucket_name = "none"
    prefix      = "none"
  }
}
```

## Outputs

```hcl
output "cloudfront_id" {
  value       = aws_cloudfront_distribution.root_site_cdn.id
  description = "The CloudFront ID to deploy the website to."
}
```
