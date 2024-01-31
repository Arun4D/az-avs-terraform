#!/usr/bin/env bash

#-----Test---------
# ./create-azure-tfstate-storage.sh "eastus" "ad-test-tsf-rg" "adtesttfstate01" "adtest-tfstate"
#------------------

if [ $# -ne 4 ]; then
  echo "Usage: ./create-azure-tfstate-storage <location> <res-group-name> <storage-account-name> <container-name>"
  exit 1
fi

LOCATION=$1
RESOURCE_GROUP_NAME=$2
STORAGE_ACCOUNT_NAME=$3
CONTAINER_NAME=$4

is_resource_group_exists=$(az group exists --name "$RESOURCE_GROUP_NAME" 2>nul)

if [ "$is_resource_group_exists" = true ]; then
  echo "Debug ==> $RESOURCE_GROUP_NAME  Resource Group already exists"
else
  az group create --name "$RESOURCE_GROUP_NAME" --location "$LOCATION"
fi

is_storage_account_exists=$(az storage account show --name "$STORAGE_ACCOUNT_NAME" --resource-group "$RESOURCE_GROUP_NAME" --query name 2>nul)

if [[ -z "$is_storage_account_exists" ]]; then
  az storage account create --resource-group "$RESOURCE_GROUP_NAME" --name "$STORAGE_ACCOUNT_NAME" --sku Standard_LRS --encryption-services blob
else
  echo "Debug ==> $STORAGE_ACCOUNT_NAME  storage account already exists"
fi

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group "$RESOURCE_GROUP_NAME" --account-name "$STORAGE_ACCOUNT_NAME" --query [0].value -o tsv)

is_storage_container_exists=$(az storage container exists --name "$CONTAINER_NAME" --account-name "$STORAGE_ACCOUNT_NAME" --account-key "$ACCOUNT_KEY" --query exists 2>nul)

if [ "$is_storage_container_exists" = true ]; then
  echo "Debug ==> $CONTAINER_NAME  storage container already exists"
else
  az storage container create --name "$CONTAINER_NAME" --account-name "$STORAGE_ACCOUNT_NAME" --account-key "$ACCOUNT_KEY"
fi
echo "-------------------------------------------"
echo "resource_group_name: $RESOURCE_GROUP_NAME"
echo "storage_account_name: $STORAGE_ACCOUNT_NAME"
echo "container_name: $CONTAINER_NAME"
echo "access_key: $ACCOUNT_KEY"
echo "-------------------------------------------"

exit 0
