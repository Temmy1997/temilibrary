RESOURCE_GROUP_NAME=DemoRG
STORAGE_ACCOUNT_NAME=tfstate$RANDOM   # must be globally unique
CONTAINER_NAME=tfstate


az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME