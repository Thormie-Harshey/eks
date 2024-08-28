terraform {
  required_version = ">=0.12.0"
  backend "s3" {
    key            = "infra/terraformstatefile"
    bucket         = "addressbook-tomiwa"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locking"
  }
}
