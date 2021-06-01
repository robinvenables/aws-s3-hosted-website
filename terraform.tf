terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "venables-terraform"
    dynamodb_table = "terraform-state-lock"
    region         = "eu-west-2"
    key            = "venables/terraform.tfstate"
    # key = "aws-s3-hosted-website/terraform.tfstate"
  }
}
