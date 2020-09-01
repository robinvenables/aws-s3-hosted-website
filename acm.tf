resource "aws_acm_certificate" "new_certificate" {
  provider = aws.us-east-1
  domain_name = var.root_domain_name
  subject_alternative_names = ["*.${var.root_domain_name}"]
  validation_method = "DNS"
	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_acm_certificate_validation" "domain_validation" {
  provider                = aws.us-east-1
  certificate_arn         = aws_acm_certificate.new_certificate.arn
  validation_record_fqdns = [for f in aws_route53_record.validation_records : f.fqdn]
}
