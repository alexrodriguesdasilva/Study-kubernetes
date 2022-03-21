terraform {
    backend "s3" {
        profile    = "alerodrigues-labs-cka-study"
        bucket     = "bucket-s3-alerodrigues-backend-tf"
        region     = "us-east-1"
        encrypt    = "true"
        key        = "labs-cka-study-alerodrigues/labs-cka-study/terraform.tfstate"
    }
} 
    
