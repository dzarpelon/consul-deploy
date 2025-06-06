# Consul Instance Module
# Variables are now defined in modules/consul_instance/variables.tf and passed in via module block.

data "aws_ami" "centos" {
  most_recent = true
  owners      = ["125523088429"] # CentOS official AWS account
  filter {
    name   = "name"
    values = ["CentOS Stream 9* x86_64*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
  filter {
    name   = "image-type"
    values = ["machine"]
  }
}

resource "aws_instance" "this" {
  count         = var.instance_count
  ami           = data.aws_ami.centos.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.security_group]
  associate_public_ip_address = var.public_ip
  key_name      = var.key_name

  root_block_device {
    volume_size = var.disk_size
    volume_type = var.disk_type
  }

  tags = merge(var.tags, { Name = var.instance_names[count.index] })
}

output "instance_ids" {
  value = aws_instance.this[*].id
}

output "public_ips" {
  value = aws_instance.this[*].public_ip
}

output "public_dns" {
  value = aws_instance.this[*].public_dns
}

output "consul_public_ips" {
  value = {
    consul_1 = aws_instance.this[0].public_ip
    consul_2 = aws_instance.this[1].public_ip
    consul_3 = aws_instance.this[2].public_ip
  }
}
