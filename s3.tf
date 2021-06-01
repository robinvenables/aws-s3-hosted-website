resource "aws_s3_bucket" "root_site" {
  bucket = var.root_domain_name
  acl    = "public-read"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.root_domain_name}/*"
            ]
        }
    ]
}
POLICY

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  website {
    index_document = var.pages.index
    error_document = var.pages.error
  }

  dynamic "logging" {
    for_each = var.access_logging ? [1] : []
    content {
      target_bucket = var.logging_bucket.name
      target_prefix = var.logging_bucket.prefix
    }
  }
}

resource "aws_s3_bucket" "www_site" {
  bucket = "www.${var.root_domain_name}"
  acl    = "private"
  website {
    redirect_all_requests_to = "https://${var.root_domain_name}"
  }
}
