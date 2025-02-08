terraform {
  backend "s3" {
    bucket  = "terraform-deploy-fiapx"
    key     = "ecs/terraform.tfstate"
    region  = "us-east-1"
  }
}
