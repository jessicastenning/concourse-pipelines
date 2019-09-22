provider "aws" {}

module "s3_bucket" {
  source                   = "git::https://github.com/cloudposse/terraform-aws-s3-bucket.git?ref=0.5.0"
  enabled                  = true
  user_enabled             = true
  versioning_enabled       = true
  allowed_bucket_actions   = ["s3:*"]
  name                     = "concourse-bucket"
}

output "iam_user_id" {
  value = "${module.s3_bucket.user_unique_id}"
}

output "iam_access_key" {
  value = "${module.s3_bucket.access_key_id}"
}

output "iam_secret_key" {
  value = "${module.s3_bucket.secret_access_key}"
  sensitive = true
}