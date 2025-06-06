variable "subnet_id" { type = string }
variable "security_group" { type = string }
variable "instance_count" { type = number }
variable "instance_names" { type = list(string) }
variable "instance_type" { type = string }
variable "disk_size" { type = number }
variable "disk_type" { type = string }
variable "public_ip" { type = bool }
variable "region" { type = string }
variable "tags" { type = map(string) }
variable "key_name" {
  description = "The name of the SSH key pair to use for the EC2 instances."
  type        = string
}
