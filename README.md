# Deploy Turbonomic Virtual Machine at IBM Cloud VPC

IBM Cloud Schematics Workspaces Terraform script to create Turbonomic virtual machine from custom image

Variables:
- turbonomic_image_id: ID of Turbonomic custom image for VPC (default "r006-7eded0f2-1e07-41ef-8aff-af853eaf769c" = turbonomic-t8c-8-4-6-private-key)
- resource_group_id: ID from a [resource group](https://cloud.ibm.com/account/resource-groups) used to create Turbonomic objects (default "7091499c38984a33a077f69c422dfd1a" = GFT ARM)
- client_name: client name used for new VPC name and Turbonomic virtual machine name (default "poc")

## CLI details

For planning phase

```shell
terraform plan
```

For apply phase

```shell
terraform apply
```

For destroy

```shell
terraform destroy
```

## Installation

To install and configure Turbonomic after virtual machine deployment see [Turbonomic Instalation](https://github.com/jpmenegatti/ibmcloud_act_turbonomic)