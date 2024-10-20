#!/bin/bash

# Base project folder
mkdir -p iam-ansible-project

# Microsoft Entra structure
mkdir -p iam-ansible-project/ms_entra/inventory
mkdir -p iam-ansible-project/ms_entra/group_vars
mkdir -p iam-ansible-project/ms_entra/playbooks
mkdir -p iam-ansible-project/ms_entra/roles/azure_ad/tasks

# AWS IAM structure
mkdir -p iam-ansible-project/aws_iam/inventory
mkdir -p iam-ansible-project/aws_iam/group_vars
mkdir -p iam-ansible-project/aws_iam/playbooks
mkdir -p iam-ansible-project/aws_iam/roles/aws_iam/tasks

# Okta structure
mkdir -p iam-ansible-project/okta/inventory
mkdir -p iam-ansible-project/okta/group_vars
mkdir -p iam-ansible-project/okta/playbooks
mkdir -p iam-ansible-project/okta/roles/okta_iam/tasks

# GCP GCIP structure
mkdir -p iam-ansible-project/gcp_gcip/inventory
mkdir -p iam-ansible-project/gcp_gcip/group_vars
mkdir -p iam-ansible-project/gcp_gcip/playbooks
mkdir -p iam-ansible-project/gcp_gcip/roles/gcp_gcip/tasks

# Create empty files
touch iam-ansible-project/ms_entra/inventory/hosts
touch iam-ansible-project/ms_entra/group_vars/azure.yml
touch iam-ansible-project/ms_entra/playbooks/create_azure_resources.yml
touch iam-ansible-project/ms_entra/roles/azure_ad/tasks/main.yml

touch iam-ansible-project/aws_iam/inventory/hosts
touch iam-ansible-project/aws_iam/group_vars/aws.yml
touch iam-ansible-project/aws_iam/playbooks/create_aws_iam_resources.yml
touch iam-ansible-project/aws_iam/roles/aws_iam/tasks/main.yml

touch iam-ansible-project/okta/inventory/hosts
touch iam-ansible-project/okta/group_vars/okta.yml
touch iam-ansible-project/okta/playbooks/create_okta_resources.yml
touch iam-ansible-project/okta/roles/okta_iam/tasks/main.yml

touch iam-ansible-project/gcp_gcip/inventory/hosts
touch iam-ansible-project/gcp_gcip/group_vars/gcp.yml
touch iam-ansible-project/gcp_gcip/playbooks/create_gcp_resources.yml
touch iam-ansible-project/gcp_gcip/roles/gcp_gcip/tasks/main.yml

echo "Folder structure created successfully."

