# ARM TEMPLATES 
ARM (Azure Resoure Manager) template isa JSON file tht defines th einfractrucutre and configuratiob you want to deploy to AZURE 
- Instead of manaually clicking through the AZURE portal, AR CAN BE USED TO CREATE resources usin gthe ARM template 

## Basic Structure
Every ARM template has these main sections:
{
  "$schema": "...",
  "contentVersion": "1.0.0.0",
  "parameters": {},
  "variables": {},
  "resources": [],
  "outputs": {}
}

## What each section does:
1. $schema => Tells Azure which version of the template language to use
2. contentVersion => Your own version number for tracking changes
3. parameters   => Values you pass in at deployment time (e.g., VM name, region)
4. variables    => Reusable values computed inside the template
5. resources    => The main section — what you actually want to create
6. outputs => Values returned after deployment (e.g., a public IP address)