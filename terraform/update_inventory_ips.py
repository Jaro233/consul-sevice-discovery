import json
import re
import subprocess

def get_terraform_output():
    # Run Terraform output command and capture the output
    output = subprocess.check_output(['terraform', 'output', '-json'])
    return json.loads(output)

def update_inventory_file(terraform_outputs, inventory_file_path):
    # Read the existing Ansible inventory file
    with open(inventory_file_path, 'r') as file:
        lines = file.readlines()

    # Regular expression to match ansible_host lines
    host_line_regex = re.compile(r'ansible_host=(\d+\.\d+\.\d+\.\d+)')

    # Update IP addresses
    for i, line in enumerate(lines):
        match = host_line_regex.search(line)
        if match:
            # Extract the host name (e.g., consul1, backend1)
            host_name = line.split()[0]
            # Replace the IP address if a corresponding Terraform output exists
            if f"{host_name}_ip" in terraform_outputs:
                new_ip = terraform_outputs[f"{host_name}_ip"]["value"]
                lines[i] = re.sub(host_line_regex, f'ansible_host={new_ip}', line)

    # Write the updated lines back to the file
    with open(inventory_file_path, 'w') as file:
        file.writelines(lines)

# Path to your Ansible inventory file
inventory_file_path = '../ansible/inventory.ini'

# Get the current outputs from Terraform
terraform_outputs = get_terraform_output()

# Update the inventory file with new IP addresses
update_inventory_file(terraform_outputs, inventory_file_path)
