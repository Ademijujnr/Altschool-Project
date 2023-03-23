terraform {
  backend "s3" {
    bucket = "adeprojectbucket"
    key    = "project/terraform.tfstate"
    region = "us-east-1"
  }
}
