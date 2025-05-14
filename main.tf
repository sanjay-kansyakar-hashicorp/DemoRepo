terraform {

  required_providers {
    aws = {
      version = ">= 5.39.0"
      source  = "hashicorp/aws"
    }
  }
  cloud {
    organization = "HashiCorp-tanushree"
    hostname     = "app.terraform.io"
    workspaces {
      project = "demo_repo"
      name    = "demo_repo_default"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_iam_role" "very-secure-role" {
  name = "demoRepo-very-secure-role"
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
    product       = "Demo-Repo"
  }
}
