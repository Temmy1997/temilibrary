# TERRAFORM COMMANDS 

## terraform validate 
* It checks if the configuration file has the right syntax. 

* If everything in the file is correct, we will see a successful validation message. 

* It the configuration has an error, it will give a systax error message and show you were the eeor is located in the file. 

## terrafom fmt 
* It is used to format the terraform configuration files to a standard style and readeble format. 

## terraform show 
* It dislays information about the currect states of the infracstucture as seen by terraform. 

* It helps you understand what resources are being managed and what their current attributes are.

## terraform providers 

* To see a list of all providers used in the configuration directory. 

## terraform output

* Print all output varibles in the configuration directory. 

## terraform refresh 
* This command is used to update the Terraform state file with the current state of the infrastructure. 

* This command checks the real-world infrastructure to see if anything has changed outside of Terraform and then updates the local state file to reflect these changes.

## terraform graph
* It generates a visual representation of the dependency graph of the resources defined in your Terraform configuration. 

* This graph illustrates how different resources depend on one another, which can help you understand the order in which Terraform will create, update, or destroy resources.

* The graph is generated in the format called DOT. 

# Mutable vs Immuyable Infrastructure
