terraform {

  backend "s3" {
    bucket = "tanushree-test1"
    key    = "terraform-states/credit-boost/terraform.tfstate"
    region = "us-west-2"
  }
  required_providers {
    aws = {
      version = ">= 5.39.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "very-secure-role" {
  name = "very-secure-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = {
    createdBy     = "terraform"
    terraformTime = "${timestamp()}"
    CanDelete     = "true"
    product       = "credit-boost"
  }
}
# This is the git root
