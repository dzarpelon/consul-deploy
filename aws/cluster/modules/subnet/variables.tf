variable "vpc_id" { type = string }
variable "region" { type = string }
variable "tags" { type = map(string) }
variable "subnet_cidr" {
  description = "CIDR block for the subnet. Must be within the VPC's CIDR."
  type        = string
}
