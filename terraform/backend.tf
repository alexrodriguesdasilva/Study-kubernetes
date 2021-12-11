terraform {
    backend "s3" {
        profile    = "alerodrigues-labs-cka-study"
        bucket     = "labs-cka-study-alerodrigues"
        region     = "us-east-1"
        encrypt    = "true"
        key        = "labs-cka-study-alerodrigues/terraform.tfstate"
    }
} 