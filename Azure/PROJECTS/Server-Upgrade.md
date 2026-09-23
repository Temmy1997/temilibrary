az deployment group create \
  --resource-group DemoRG \
  --template-file Azure/PROJECTS/template.json \
  --parameters sshPublicKey="$(cat Azure/PROJECTS/key/demokey.pub)" \
  --query "properties.outputs.publicIP.value" \
  --output tsv