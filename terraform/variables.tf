variable project_name {
  default     = "labs-cka-study"
}

variable region {
  default     = "us-east-1"
}

variable tags {
  default     = {
    Labs            = "cka"
    Description     = "Labs-CKA-Study"
    author          = "Alex Rodrigues da Silva"
    Repo_Terraform  = "https://github.com/alexrodriguesdasilva/labs-cka-study"
  }
}


#Variables-EC2
variable ami {
  default     = "ami-083654bd07b5da81d"
}

variable instance_type {
  default     = "t3.medium"
}

#Variables - Subnet and VPC
variable subnet_id {
  default     = "subnet-700b9c16"
}

variable  vpc_id{
  default     = "vpc-4642e13b"
}
