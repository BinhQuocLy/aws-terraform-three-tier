# AWS-Terraform Use Case 1

![diagram2](docs/diagram2.png)

## Definition of Done



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

## Access the instances via SSH

```bash
terraform output -raw private_key > tf_test_key_pair.pem
chmod 400 "tf_test_key_pair.pem"
ssh -i "tf_test_key_pair.pem" ec2-user@<PublicIP>
```
