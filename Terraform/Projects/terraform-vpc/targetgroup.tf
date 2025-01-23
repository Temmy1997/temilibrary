resource "aws_lb_target_group" "terraformTG" { 
    name     = "app-target-group"
    port     = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.terraformvpc.id
    
    health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-399"
  }
}


# The name of the target group (app-target-group).
# The port on which to listen (80).
# The protocol (HTTP).
# The VPC in which to create the target group (main VPC).
# The health check configuration:
# Interval: 30 seconds.
# Path: /.
# Timeout: 5 seconds.
# Healthy threshold: 5.
# Unhealthy threshold: 2.
# Matcher: response codes in the range 200-399.