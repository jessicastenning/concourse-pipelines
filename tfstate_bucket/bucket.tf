provider "aws" {
  region = "eu-west-1"
}

resource "aws_s3_bucket" "tfstate-bucket" {
  bucket = "tfstate-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name    = "tfstate-bucket"
    Project = "Concourse"
  }
}