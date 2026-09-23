# Launch Configuration
resource "aws_launch_configuration" "app" {
  name          = "app-launch-configuration"
  image_id      = "ami-0dc34922f894188c2" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  security_groups = [
    aws_security_group.ec2_sg.id
  ]

  user_data = <<-EOF
              sudo yum update -y 
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Hello World from $(hostname -f)</h1>" | sudo tee /var/www/html/index.html > /dev/null
              sudo systemctl restart httpd
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

## launch configuration for the Auto Scaling Group (ASG).
## The name of the launch configuration (app-launch-configuration).
## The Amazon Machine Image (AMI) ID (ami-0c55b159cbfafe1f0), which is an Amazon Linux 2 AMI.
## The instance type (t2.micro).
## The security group (ec2_sg).
## The user data script to install and start Apache HTTP Server and create a simple HTML page.
## The create_before_destroy lifecycle rule ensures that new instances are created before the old ones are destroyed during updates.