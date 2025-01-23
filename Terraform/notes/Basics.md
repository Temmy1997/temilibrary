# TERRAFORM 

* Terraform is a popular open-source infrastructure-as-code tool that allows you to automate the provisioning and management of infrastructure resources.

* Terraform uses HasiCorp Configuration Language 

* It's great for managing a variety of providers, from cloud services like AWS, Azure, and Google Cloud, to on-premises solutions. 

* It support  multiple cloud providers as well as on-premises and open-source tools. 

* Users can define infrastructure resources using a single configuration and use Terraform to manage resources across different environments.

## HOW TO INSTALL TERRFORM ON WINDOWS

--- https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-cli
--- https://developer.hashicorp.com/terraform/install

## Terraform Workflow

1. Write configuration file

2. INIT
Terraform initializes the project and identify the providers to be used for the target environmant 
Run terraform init

3. PLAN:
Run the terraform plan command.
This step shows you what Terraform will do before actually doing it.

4. APPLY:
Apply the Changes.
If the plan looks good, you can apply the changes using the terraform apply command. 

## HashiCorp Configuration Language (HCL)

1. BLOCK:  HCL uses blocks to define different configurations. 
* Blocks start with a keyword and are enclosed in curly braces {}. 
* For example:
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

2. Attributes: Inside blocks, you define attributes. Each attribute has a name, an equals sign, and a value. 
* Uses key = Value format 
* For instance:
ami = "ami-0c55b159cbfafe1f0"

3. Variables: HCL supports variables, allowing you to parameterize your configurations. 
* You can define variables and then reference them within your blocks.

4. Comments: Comments in HCL start with a # symbol. 
* They are useful for adding explanations or annotations to your code.

Expressions: HCL supports expressions for more dynamic configurations. You can use variables and functions to create flexible configurations.


## Assignment
1. Explain the diffrent concepts that are used in a HCL(.tf) resources block 
terrform funt
2. Using for loop concepts in HCL, Create 3 s3 buckets in aws usign terraform resources

# Variables 
* variables are used to parameterize your configurations, making them more flexible and reusable. 

## Varaibles Block 

## variables.tf
variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

## Vaariables Types 
In Terraform, variables have types associated with them, defining the kind of data that a variable can hold. Here are some common variable types in Terraform:

1. String
variable "name" {
  type    = string
  default = "John"
}

2. Number 

variable "age" {
  type    = number
  default = 25
}

3. List 

variable "colors" {
  type    = list(string)
  default = ["red", "green", "blue"]
}

(Note: You can have duplicate values)

4. Boolean 

variable "is_enabled" {
  type    = bool
  default = true
}

5. Map 

variable "settings" {
  type    = map(string)
  default = { key1 = "value1", key2 = "value2" }
}


6. Set 

variable "unique_numbers" {
  type    = set(number)
  default = [1, 2, 3]
}

(Set cannot have duplicate values)

7. Object 

variable "user" {
  type = object({
    name  = string
    age   = number
    email = string
  })

* EXAMPLE:
variable "bella" {
  type = object({
    name  = "Alice"
    age   = 30
    email = "alice@example.com"
  })
}

8. Tuples 
*Similar to list 

variable kitty {
  type    = tuple(string, number, bool)
  default = ["cat", "7", "true"]
}