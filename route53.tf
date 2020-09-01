data "aws_route53_zone" "my_dns_zone" {
  name = var.root_domain_name
}

resource "aws_route53_record" "root_record" {
  zone_id = data.aws_route53_zone.my_dns_zone.zone_id
  name = ""
  type = "A"
  alias {
    name                   = aws_cloudfront_distribution.root_site_cdn.domain_name
    zone_id                = aws_cloudfront_distribution.root_site_cdn.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_record" {
  zone_id = data.aws_route53_zone.my_dns_zone.zone_id
  name    = "www.${var.root_domain_name}"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.www_site_cdn.domain_name
    zone_id                = aws_cloudfront_distribution.www_site_cdn.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "validation_records" {
  for_each = {
    for dvo in aws_acm_certificate.new_certificate.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.my_dns_zone.zone_id
}
