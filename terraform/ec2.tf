###Create Key Pair
resource "aws_key_pair" "alerodrigues-labs-cka-study-key" {
  key_name                  = format("%s-key", var.project_name)
  public_key                = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCjNtqW1c0GoLkQ34SwDTYdJwJUselcMe85Cxecc2jWLRCXnGYSXK77aRgzUeSoINNf+RVg1d6ZAmVH7LDPMKNPi1CCsHIji2ylAs4nsr2/MNHJE5hDmO+vVk2wWUu8grTb2AG3S1TjMoANy5gNkDiWNFmPgNmfHolcGxgN/zk8gkqRTh1NNKM5w6m7+Mi3jBybl7oKn8b3+DxEOln12ICTUEzaAWgAdfPbw4LG1DEivcY26fIhcKQZFcDw627EUT2amRiN3loIi4OmuiWDuvsgr/zlxTc+cm0e8jmDT0E69Vo4eOMCpCxqwEb+JUwoCcoNW9F7b7G/pvblfPebjDvFQ/MhBtfZTYDaF2S+2JIvBr3+VJIly/kmpdbidjYow72rR+sAdCOgP7k4Ajs6NZ0E6Xbry3PO6x395xQiDiyXziSqYhWVidqWPkN8eNLfWicJC7DON2g4cm+J0DAVurOlbXavE8pKpCvVQqRrCLS2z7KOrPRLrNHMJ3xWoGNS43c="
                
  tags                      = var.tags
}

###Create Nodes Masters K8S
resource "aws_instance" "alerodrigues-labs-cka-study-master" {
  count                     = 1
  ami                       = var.ami
  instance_type             = var.instance_type
  key_name                  = format("%s-key", var.project_name)

  vpc_security_group_ids    = ["${aws_security_group.acesso-ssh.id}"]
  subnet_id                 = var.subnet_id

  tags = merge(
    var.tags,
    {
      Name = "alerodrigues-labs-cka-study-master-${count.index}"
      tyme = "master"
    },
  )
}

###Create Nodes Workers K8S
resource "aws_instance" "alerodrigues-labs-cka-study-workers" {
  count                     = 2
  ami                       = var.ami
  instance_type             = var.instance_type
  key_name                  = format("%s-key", var.project_name)

  vpc_security_group_ids    = ["${aws_security_group.acesso-ssh.id}"]
  subnet_id                 = var.subnet_id

    tags = merge(
    var.tags,
    {
      Name = "alerodrigues-labs-cka-study-worker-${count.index}"
      type = "worker"
    },
  )
} 