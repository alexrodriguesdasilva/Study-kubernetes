resource "aws_security_group" "acesso-ssh" {
  name = "acesso-ssh"
  description = "acesso-ssh"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }
  
  ingress {
    from_port     = 22
    to_port       = 22  
    protocol      =  "tcp"
    cidr_blocks   = ["186.220.36.69/32"]
  }

  egress {
    from_port     = 22
    to_port       = 22  
    protocol      =  "tcp"
    cidr_blocks   = ["0.0.0.0/0"]
  }
} 