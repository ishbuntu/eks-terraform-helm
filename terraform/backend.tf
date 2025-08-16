terraform {
  backend "s3" {
    bucket               = "terraform-state-09d82"
    key                  = "terraform.tfstate"
    region               = "eu-west-1"
    dynamodb_table       = "terraform-locks-09d82"
    encrypt              = true
    workspace_key_prefix = "env"
  }
}
