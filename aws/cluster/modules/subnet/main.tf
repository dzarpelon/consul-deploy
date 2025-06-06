# Subnet Module
resource "aws_subnet" "this" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_cidr
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
  tags                    = var.tags
}

output "subnet_id" {
  value = aws_subnet.this.id
}

# Variables are defined in modules/subnet/variables.tf
