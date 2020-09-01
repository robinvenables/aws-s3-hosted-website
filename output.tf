output "cloudfront_id" {
  value       = aws_cloudfront_distribution.root_site_cdn.id
  description = "The CloudFront ID to deploy the website to."
}
