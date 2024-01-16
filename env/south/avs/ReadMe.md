# AVS IaC

## Introduction

## Terraform

## Build
### Pre-requisite

### Run Steps

1. Initialize Terraform

* Option 1: Preferred - without upgrade
````
terraform init
````
* Option 2: With version upgrade if you migrate to latest version
````
terraform init -upgrade
````

2. Create a terraform execution plan

````
terraform plan -out main.tfplan -var-file="../../../config/global.tfvars" -var-file="../../../config/south/avs.tfvars"
````
#### Step2 : Plan
````
terraform plan -out main.tfplan -var-file="../../config/south/avs.tfvars"
````
