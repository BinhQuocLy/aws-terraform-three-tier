# AWS-Terraform Three Tier Architecture with High Availability

An AWS highly available three-tier architecture, provisioned with Terraform.

![diagram2](docs/diagram2.png)

## Definition of Done

The returned results will be almost continuously different, alternating between IPs for each web tier and app tier.

![demo](docs/demo.png)

## Run

### 1. Credentials

Create a `.tf` file with the following template:

```hcl
provider "aws" {
  region     = "..."
  access_key = "..."
  secret_key = "..."
}
```

### 2. Apply

```hcl
terraform init
terraform plan
terraform apply
```

### 3. Destroy

```hcl
terraform destroy
```
