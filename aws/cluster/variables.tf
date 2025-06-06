variable "region" {
  description = "AWS region to deploy resources in."
  type        = string
  default     = "eu-central-1"
}

variable "public_ip" {
  description = "Whether to associate a public IP address with EC2 instances."
  type        = bool
  default     = true
}

variable "ssh_cidr" {
  description = "CIDR blocks allowed to SSH into instances."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "instance_count" {
  description = "Number of Consul nodes."
  type        = number
  default     = 3
}

variable "instance_names" {
  description = "Names for Consul nodes."
  type        = list(string)
  default     = ["consul-1", "consul-2", "consul-3"]
}

variable "instance_type" {
  description = "EC2 instance type (must have >=4GB RAM)."
  type        = string
  default     = "t3.medium"
}

variable "disk_size" {
  description = "Root EBS volume size in GB."
  type        = number
  default     = 50
}

variable "disk_type" {
  description = "EBS volume type."
  type        = string
  default     = "gp3"
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {
    "Name" = "consul-lab"
  }
}

variable "key_name" {
  description = "The name of the SSH key pair to use for the EC2 instances."
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet. Must be within the VPC's CIDR."
  type        = string
  default     = "172.31.1.0/24" # Default for AWS default VPC
}
