#!/opt/homebrew/Cellar/ansible/11.4.0/libexec/bin/python
import boto3
import json
import os

def main():
    ec2 = boto3.resource('ec2', region_name=os.environ.get('AWS_REGION', 'eu-central-1'))
    filters = [{
        'Name': 'tag:Name',
        'Values': ['consul-*']
    }]
    hosts = []
    for instance in ec2.instances.filter(Filters=filters):
        if instance.state['Name'] == 'running':
            # Always extract the Name tag value
            name_tag = next((tag['Value'] for tag in instance.tags if tag['Key'] == 'Name'), instance.id)
            hosts.append({
                'name': name_tag,  # Use the Name tag as inventory_hostname
                'ansible_host': instance.public_ip_address or instance.private_ip_address,
                'ansible_user': 'ec2-user',
                'ansible_ssh_private_key_file': os.environ.get('ANSIBLE_PRIVATE_KEY_FILE', os.path.expanduser('~/.ssh/Diego Zarpelon Key Pair.pem'))
            })
    inventory = {
        'all': {
            'hosts': [h['name'] for h in hosts],
            'vars': {},
        },
        '_meta': {
            'hostvars': {h['name']: h for h in hosts}
        }
    }
    print(json.dumps(inventory))

if __name__ == "__main__":
    main()
