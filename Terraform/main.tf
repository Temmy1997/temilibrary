provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "terraform-instance" {
  ami           = "ami-079db87dc4c10ac91"
  instance_type = "t2.micro"
  subnet_id = "subnet-01a915ae91d6d605d"
  tags = {
    Name = "terraform"
  }
}

