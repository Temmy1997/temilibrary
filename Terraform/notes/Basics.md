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
- Terraform init initializes the Terraform working directory by downloading the required providers and modules and setting up the backend so Terraform is ready to create and manage infrastructure.
- Find required provider plug in and downsload it for you 
Run terraform init

3. PLAN:
- This step shows you what Terraform will do before actually doing it.
Run the terraform plan command.


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

# Terraform Block Types —

## 1. The big picture

Every `.tf` file is made of **blocks** — chunks wrapped in `{ }` that each do one specific job. There are 8 main block types you'll run into. 

## TYPES 
1. `terraform` block — 
Configures Terraform itself: which provider versions you need, where to store state (the backend), and the minimum Terraform version. You'll usually have just one of these per project, near the top.

```hcl
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
```

## 2. `provider` block —


```hcl
provider "aws" {
  region = "us-east-1"
}
```

You can configure the same provider more than once (e.g. two AWS regions) using an `alias`, and reference the extra one by `aws.west` etc.

---

## 4. `resource` block — the thing you're building

The workhorse block. Every actual piece of infrastructure — a server, a bucket, a database, a network — is declared as a `resource`. Almost everything you manage with Terraform shows up here.

```hcl
resource "aws_instance" "web" {
  ami           = "ami-0123456789"
  instance_type = "t3.micro"
}
```


## 5. `data` block — read something that already exists

A read-only lookup. It doesn't create or change anything — it just fetches info about something that's already out there, so you can use that info elsewhere in your config.

```hcl
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
}
```

Example use: "find me the latest Ubuntu AMI ID" instead of hardcoding an AMI ID that goes stale.


## 6. `variable` block — input in

Defines a setting your configuration accepts from the outside, so you're not hardcoding values. Like a blank on a form someone else fills in.

```hcl
variable "instance_size" {
  type        = string
  default     = "t3.micro"
  description = "EC2 instance size to launch"
}
```

You use it elsewhere as `var.instance_size`.


## 7. `output` block — info out

Hands information back — either printed to your terminal after `terraform apply`, or passed up to a parent module that called this one.

```hcl
output "instance_ip" {
  value       = aws_instance.web.public_ip
  description = "Public IP of the web server"
}

## 8`locals` block — reusable named value

Defines a named value or expression once, so you can reuse it instead of repeating the same calculation/string all over your config.

```hcl
locals {
  env_prefix = "${var.environment}-${var.project_name}"
}
```

You use it elsewhere as `local.env_prefix`.

---

## 9. `module` block — reusable bundle of all the above

Calls a packaged, reusable chunk of Terraform code (a child module) — its own folder of `.tf` files with its own resources, variables, and outputs. See the separate modules notes doc for the full deep-dive on these.

```hcl
module "web_server" {
  source = "./modules/server"
  count  = 3
}
```



## 10. Cheat-sheet

| Block | Plain-English job |
|---|---|
| `terraform` | Project-wide settings (versions, backend). |
| `provider` | Which cloud/account to talk to. |
| `resource` | The actual thing you're building. |
| `data` | Read something that already exists. |
| `variable` | Input you feed in. |
| `output` | Info handed back out. |
| `locals` | A reusable named value/expression. |
| `module` | A reusable bundle of the above. |

---

## 11. TL;DR

Terraform configs are built from a small set of block types, each with one job: `terraform` sets project-wide rules, `provider` picks the cloud, `resource` is what actually gets built, `data` reads existing things, `variable` and `output` handle info going in and out, `locals` avoids repeating yourself, and `module` bundles all of the above into a reusable package.

---

*Compiled from developer.hashicorp.com/terraform documentation pages: Configuration syntax, Resources, Data sources, Variables, Outputs, Local values, Providers, and Modules overview.*




