terraform {
  backend "s3" {
    bucket = "mybucket-migrate-test"
    key    = "InternalDemoRepo/terraform.tfstate"
    region = "eu-north-1"
  }

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }
  }
}

provider "random" {}

resource "random_uuid" "unique_marker" {
  # This will generate a new UUID on each Terraform apply
}

resource "random_id" "execution_signature" {
  # This will generate a new random ID based on the current timestamp
  byte_length = 8
}

output "unique_id" {
  value       = random_uuid.unique_marker.result
  description = "A universally unique identifier generated during each Terraform execution"
}

output "execution_signature" {
  value       = random_id.execution_signature.hex
  description = "A random identifier representing the specific runtime instance"
}