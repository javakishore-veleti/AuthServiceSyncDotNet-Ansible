#!/bin/bash

# Populating ms_entra inventory/hosts file
echo "[ms_entra]
localhost ansible_connection=local" > iam-ansible-project/ms_entra/inventory/hosts

# Populating ms_entra group_vars/azure.yml file
echo "azure_subscription_id: '<your_subscription_id>'
azure_client_id: '<your_client_id>'
azure_secret: '<your_client_secret>'
azure_tenant: '<your_tenant_id>'
azure_app_name: 'AzureApp'
azure_app_uri: 'https://azureapp.example.com'" > iam-ansible-project/ms_entra/group_vars/azure.yml

# Populating ms_entra playbooks/create_azure_resources.yml
echo "--- 
- name: Create Microsoft Entra Resources
  hosts: ms_entra
  gather_facts: no
  roles:
    - azure_ad" > iam-ansible-project/ms_entra/playbooks/create_azure_resources.yml

# Populating ms_entra roles/azure_ad/tasks/main.yml
echo "--- 
- name: Create Azure AD application
  azure.azcollection.azure_ad_application:
    display_name: '{{ azure_app_name }}'
    identifier_uris:
      - '{{ azure_app_uri }}'
    password_credential:
      display_name: 'AppCredential'
      end_date: '2025-01-01T00:00:00Z'
    tenant: '{{ azure_tenant }}'
    client_id: '{{ azure_client_id }}'
    secret: '{{ azure_secret }}'
    subscription_id: '{{ azure_subscription_id }}'" > iam-ansible-project/ms_entra/roles/azure_ad/tasks/main.yml

# Populating aws_iam inventory/hosts file
echo "[aws_iam]
localhost ansible_connection=local" > iam-ansible-project/aws_iam/inventory/hosts

# Populating aws_iam group_vars/aws.yml file
echo "aws_access_key: '<your_aws_access_key>'
aws_secret_key: '<your_aws_secret_key>'
aws_region: 'us-east-1'
aws_iam_role_name: 'AWSRole'" > iam-ansible-project/aws_iam/group_vars/aws.yml

# Populating aws_iam playbooks/create_aws_iam_resources.yml
echo "--- 
- name: Create AWS IAM Resources
  hosts: aws_iam
  gather_facts: no
  roles:
    - aws_iam" > iam-ansible-project/aws_iam/playbooks/create_aws_iam_resources.yml

# Populating aws_iam roles/aws_iam/tasks/main.yml
echo "--- 
- name: Create IAM Role in AWS
  aws_iam_role:
    name: '{{ aws_iam_role_name }}'
    assume_role_policy_document: '{{ iam_trust_policy }}'
    state: present
    region: '{{ aws_region }}'
    aws_access_key: '{{ aws_access_key }}'
    aws_secret_key: '{{ aws_secret_key }}'" > iam-ansible-project/aws_iam/roles/aws_iam/tasks/main.yml

# Populating okta inventory/hosts file
echo "[okta]
localhost ansible_connection=local" > iam-ansible-project/okta/inventory/hosts

# Populating okta group_vars/okta.yml file
echo "okta_org_url: 'https://yourcompany.okta.com'
okta_api_token: '<your_okta_api_token>'
okta_app_name: 'OktaApp'" > iam-ansible-project/okta/group_vars/okta.yml

# Populating okta playbooks/create_okta_resources.yml
echo "--- 
- name: Create Okta Resources
  hosts: okta
  gather_facts: no
  roles:
    - okta_iam" > iam-ansible-project/okta/playbooks/create_okta_resources.yml

# Populating okta roles/okta_iam/tasks/main.yml
echo "--- 
- name: Create Okta application
  uri:
    url: '{{ okta_org_url }}/api/v1/apps'
    method: POST
    headers:
      Authorization: 'SSWS {{ okta_api_token }}'
      Content-Type: 'application/json'
    body_format: json
    body:
      label: '{{ okta_app_name }}'
      signOnMode: 'OPENID_CONNECT'
      settings:
        oauthClient:
          client_uri: '{{ okta_app_uri }}'
    status_code: 200" > iam-ansible-project/okta/roles/okta_iam/tasks/main.yml

# Populating gcp_gcip inventory/hosts file
echo "[gcp_gcip]
localhost ansible_connection=local" > iam-ansible-project/gcp_gcip/inventory/hosts

# Populating gcp_gcip group_vars/gcp.yml file
echo "gcp_project: '<your_gcp_project>'
gcp_app_name: 'GCPApp'" > iam-ansible-project/gcp_gcip/group_vars/gcp.yml

# Populating gcp_gcip playbooks/create_gcp_resources.yml
echo "--- 
- name: Create GCP GCIP Resources
  hosts: gcp_gcip
  gather_facts: no
  roles:
    - gcp_gcip" > iam-ansible-project/gcp_gcip/playbooks/create_gcp_resources.yml

# Populating gcp_gcip roles/gcp_gcip/tasks/main.yml
echo "--- 
- name: Create GCP Identity Platform application
  gcp_identity:
    name: '{{ gcp_app_name }}'
    project: '{{ gcp_project }}'
    state: present
  delegate_to: localhost" > iam-ansible-project/gcp_gcip/roles/gcp_gcip/tasks/main.yml

echo "Files populated with content successfully."
