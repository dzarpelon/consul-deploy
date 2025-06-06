# Use the default VPC and an existing subnet

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_subnet" "default" {
  id = data.aws_subnets.default.ids[0]
}

module "security_group" {
  source     = "./modules/security_group"
  vpc_id     = data.aws_vpc.default.id
  ssh_cidr   = var.ssh_cidr
  tags       = var.tags
}

module "consul_instances" {
  source          = "./modules/consul_instance"
  subnet_id       = data.aws_subnet.default.id
  security_group  = module.security_group.security_group_id
  instance_count  = var.instance_count
  instance_names  = var.instance_names
  instance_type   = var.instance_type
  disk_size       = var.disk_size
  disk_type       = var.disk_type
  public_ip       = var.public_ip
  region          = var.region
  tags            = var.tags
  key_name        = var.key_name
}

module "ansible_provision" {
  source             = "./modules/ansible_provision"
  instance_public_ips = module.consul_instances.public_ips
  instance_names     = var.instance_names
  key_name           = var.key_name
  depends_on         = [module.consul_instances]
}
