# IAM Ansible Project

This repository contains an Ansible project for managing various IAM (Identity and Access Management) providers, including:
- Microsoft Entra (Azure AD)
- AWS IAM
- Okta
- GCP GCIP (Google Cloud Identity Platform)

Each IAM provider is organized into its own directory, with separate inventories, group variables, playbooks, and roles.

## Project Structure

The repository is structured to support multiple IAM providers, as shown below:

```plaintext
iam-ansible-project/
├── ms_entra/               # Microsoft Entra (Azure AD) related configurations
│   ├── inventory/
│   ├── group_vars/
│   ├── playbooks/
│   └── roles/
├── aws_iam/                # AWS IAM related configurations
│   ├── inventory/
│   ├── group_vars/
│   ├── playbooks/
│   └── roles/
├── okta/                   # Okta IAM related configurations
│   ├── inventory/
│   ├── group_vars/
│   ├── playbooks/
│   └── roles/
├── gcp_gcip/               # GCP GCIP related configurations
│   ├── inventory/
│   ├── group_vars/
│   ├── playbooks/
│   └── roles/
```

## Prerequisites

### 1. **Ansible Installation**

#### **MacBook (macOS)**

You can install Ansible on macOS using `brew`:

```bash
brew install ansible
```

If you don't have Homebrew installed, follow the instructions on [Homebrew's website](https://brew.sh/) to install it first.

#### **Windows**

To install Ansible on Windows, you can use the Windows Subsystem for Linux (WSL). Follow these steps:

1. **Install WSL**:
   Open PowerShell as Administrator and run the following command:

   ```powershell
   wsl --install
   ```

2. **Install Ubuntu**:
   After WSL is installed, install Ubuntu from the Microsoft Store.

3. **Install Ansible**:
   Open the Ubuntu terminal from WSL and run the following commands:

   ```bash
   sudo apt update
   sudo apt install ansible
   ```

### 2. **Azure Ansible Collection**

If you're managing Microsoft Entra (Azure AD), you will need the Azure Ansible collection:

```bash
ansible-galaxy collection install azure.azcollection
```

### 3. **IAM Access Credentials**

- **AWS IAM Access**: Ensure you have AWS CLI or proper access credentials for AWS IAM in the `group_vars/aws.yml`.
- **Okta API Token**: Make sure you have the Okta API token and organization details to be placed in `group_vars/okta.yml`.
- **GCP Service Account**: For GCP GCIP, you will need a service account and project configuration in `group_vars/gcp.yml`.

## Setup

### Folder Structure Setup
If you need to create the folder structure and populate the files, run the following shell scripts:

1. **Create Folder Structure**:
   ```bash
   bash create_iam_project_structure.sh
   ```

2. **Populate File Contents**:
   ```bash
   bash populate_iam_project_files.sh
   ```

### Configuring Providers

Each provider has its own configuration files located in the `group_vars/` folder within the respective provider's directory. Make sure you populate the appropriate credentials and configuration details.

#### Example: Microsoft Entra (Azure AD)

```yaml
azure_subscription_id: "<your_subscription_id>"
azure_client_id: "<your_client_id>"
azure_secret: "<your_client_secret>"
azure_tenant: "<your_tenant_id>"
```

## Running the Playbooks

You can run the playbooks from the project root without needing to change directories. Use the following commands to run playbooks for each IAM provider:

### Microsoft Entra (Azure AD)

```bash
ansible-playbook -i ms_entra/inventory/hosts ms_entra/playbooks/create_azure_resources.yml
```

### AWS IAM

```bash
ansible-playbook -i aws_iam/inventory/hosts aws_iam/playbooks/create_aws_iam_resources.yml
```

### Okta IAM

```bash
ansible-playbook -i okta/inventory/hosts okta/playbooks/create_okta_resources.yml
```

### GCP GCIP

```bash
ansible-playbook -i gcp_gcip/inventory/hosts gcp_gcip/playbooks/create_gcp_resources.yml
```

## Roles

Each IAM provider has its own role under the `roles/` directory. These roles contain the specific tasks to manage IAM resources for that provider.

### Example: Microsoft Entra Role

```yaml
---
- name: Create Azure AD application
  azure.azcollection.azure_ad_application:
    display_name: "{{ azure_app_name }}"
    identifier_uris:
      - "{{ azure_app_uri }}"
    password_credential:
      display_name: "AppCredential"
      end_date: "2025-01-01T00:00:00Z"
    tenant: "{{ azure_tenant }}"
    client_id: "{{ azure_client_id }}"
    secret: "{{ azure_secret }}"
    subscription_id: "{{ azure_subscription_id }}"
```

## Contributing

Contributions are welcome! Please submit a pull request or open an issue if you'd like to contribute or if you encounter any issues.

## License

This project is licensed under the MIT License.

