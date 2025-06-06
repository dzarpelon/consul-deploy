# Consul AWS Cluster (Terraform)

This project provisions a modular AWS environment using Terraform, creating three RHEL EC2 instances (consul-1, consul-2, consul-3) in a dedicated VPC and subnet. All parameters are configurable via `terraform.tfvars`.

## Features

- Modular structure: VPC, subnet, security group, and EC2 instances as separate modules
- Configurable instance specs (RAM, disk size/type, public IP, SSH CIDR, region, etc.)
- Default region: eu-central-1
- Default: public IP enabled, SSH allowed from anywhere
- All resources tagged with `consul-lab`
- Uses EBS gp3 for disks

## Usage

1. Edit `terraform.tfvars` to set your desired parameters.
2. Run `terraform init` and `terraform apply`.

## Structure

- `modules/` — reusable Terraform modules
- `main.tf` — root module wiring everything together
- `variables.tf` — input variables
- `outputs.tf` — outputs
- `terraform.tfvars` — variable values

---

For more details, see comments in each file.
