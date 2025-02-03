#!/bin/bash

# Path to the existing Ansible inventory file
ANSIBLE_INVENTORY_FILE="../../../ansible/inventory/separated/inventory.ini"

# Use terraform output command to get the Terraform output in JSON format
TERRAFORM_OUTPUT=$(terraform output -json)

# Extract the "ansible_host" object from the JSON
ANSIBLE_HOST_WAW_JSON=$(echo "$TERRAFORM_OUTPUT" | jq -r .ansible_hosts_waw.value)
ANSIBLE_HOST_DE_JSON=$(echo "$TERRAFORM_OUTPUT" | jq -r .ansible_hosts_de.value)
ANSIBLE_HOST_BHS_JSON=$(echo "$TERRAFORM_OUTPUT" | jq -r .ansible_hosts_bhs.value)

# Loop through the WAW instances
echo "$ANSIBLE_HOST_WAW_JSON" | jq -r 'to_entries[] | [.key, .value] | join(" ")' | while IFS= read -r line; do
  # Extract the instance name and ansible_host value
  instance_name=$(echo "$line" | awk '{print $1}')
  ansible_host_value=$(echo "$line" | awk '{print $2}' | awk -F 'ansible_host=' '{print $2}')
  # Replace the corresponding line in the Ansible inventory file
  sed -i "/^$instance_name / s/\(ansible_host=\)[^ ]*/\1$ansible_host_value/" "$ANSIBLE_INVENTORY_FILE"

done

# Loop through the DE instances
echo "$ANSIBLE_HOST_DE_JSON" | jq -r 'to_entries[] | [.key, .value] | join(" ")' | while IFS= read -r line; do
  # Extract the instance name and ansible_host value
  instance_name=$(echo "$line" | awk '{print $1}')
  ansible_host_value=$(echo "$line" | awk '{print $2}' | awk -F 'ansible_host=' '{print $2}')
  # Replace the corresponding line in the Ansible inventory file
  sed -i "/^$instance_name / s/\(ansible_host=\)[^ ]*/\1$ansible_host_value/" "$ANSIBLE_INVENTORY_FILE"

done

# Loop through the BHS instances
echo "$ANSIBLE_HOST_BHS_JSON" | jq -r 'to_entries[] | [.key, .value] | join(" ")' | while IFS= read -r line; do
  # Extract the instance name and ansible_host value
  instance_name=$(echo "$line" | awk '{print $1}')
  ansible_host_value=$(echo "$line" | awk '{print $2}' | awk -F 'ansible_host=' '{print $2}')
  # Replace the corresponding line in the Ansible inventory file
  sed -i "/^$instance_name / s/\(ansible_host=\)[^ ]*/\1$ansible_host_value/" "$ANSIBLE_INVENTORY_FILE"
done


echo "Ansible inventory file updated successfully!"
