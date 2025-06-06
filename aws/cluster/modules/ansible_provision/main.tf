# Ansible Provisioner Module
# This module triggers an Ansible playbook after EC2 creation using a null_resource and local-exec.

variable "instance_public_ips" {
  description = "List of public IPs of the EC2 instances."
  type        = list(string)
}

variable "instance_names" {
  description = "List of hostnames for the EC2 instances."
  type        = list(string)
}

resource "null_resource" "wait_for_ssh" {
  triggers = {
    always_run = timestamp()
    ips        = join(",", var.instance_public_ips)
  }

  provisioner "local-exec" {
    command = "for ip in ${join(" ", var.instance_public_ips)}; do echo Waiting for SSH on $ip...; for i in {1..30}; do nc -z $ip 22 && echo SSH available on $ip && break || (echo 'Still waiting for SSH on' $ip; sleep 10); done; done"
  }
}

resource "null_resource" "ansible_provision" {
  triggers = {
    always_run = timestamp()
    ips        = join(",", var.instance_public_ips)
    names      = join(",", var.instance_names)
  }

  provisioner "local-exec" {
    working_dir = "${path.root}"
    environment = {
      ANSIBLE_PRIVATE_KEY_FILE = pathexpand("~/.ssh/${var.key_name}.pem")
    }
    command     = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ansible/inventory.py ansible/provision.yml"
  }

  depends_on = [null_resource.wait_for_ssh]
}
