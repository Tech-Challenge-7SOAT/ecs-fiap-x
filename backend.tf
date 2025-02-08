terraform {
  backend "s3" {
    bucket  = "terraform-deploy"
    key     = "ecs/terraform.tfstate"
    region  = "us-east-1"
  }
}
