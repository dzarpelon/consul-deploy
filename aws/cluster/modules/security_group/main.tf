# Security Group Module
resource "aws_security_group" "this" {
  name        = "consul-lab-sg"
  description = "Allow SSH"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

output "security_group_id" {
  value = aws_security_group.this.id
}

# Variables are defined in modules/security_group/variables.tf
