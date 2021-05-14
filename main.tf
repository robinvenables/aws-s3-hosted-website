provider "aws" {
  region = var.region
}

data "aws_iam_account_alias" "this_account" {}
