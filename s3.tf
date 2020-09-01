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
  website {
    index_document = "index.html"
    error_document = "404.html"
  }

  logging {
    target_bucket = "${data.aws_iam_account_alias.this_account.account_alias}-log"
    target_prefix = "${var.root_domain_name}/"
  }
}

resource "aws_s3_bucket" "www_site" {
  bucket = "www.${var.root_domain_name}"
  acl    = "private"
  website {
    redirect_all_requests_to = "https://${var.root_domain_name}"
  }
}
