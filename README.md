# Create Turbonomic Virtual Machine at IBM Cloud VPC

Terraform script to be used with IBM Cloud Schematics Workspaces to create Turbonomic virtual machine from a custom image

Variables:
- turbonomic_image_id: ID of Turbonomic custom image for VPC (default "r006-47125f1b-b95d-47f5-8e4c-1395254549ce" = turbonomic-t8c-8-4-6)
- client_name: client name used for new VPC name and Turbonomic virtual machine name (default "poc")

## CLI details:

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

Note: To install and configure Turbonomic after virtual machine deployment see [Turbonomic Ansible](https://github.com/jpmenegatti/ibmcloud_act_turbonomic)