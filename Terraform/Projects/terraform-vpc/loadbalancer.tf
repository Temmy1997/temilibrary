resource "aws_lb" "terraformLB" {
  name               = "app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.publicsubnet1.id, aws_subnet.publicsubnet2.id]

  tags = {
    Name = "app-lb"
  }
}


# The name of the load balancer (app-load-balancer).
# It is public-facing (internal = false).
## internal - (Optional) If true, the LB will be internal. Defaults to false.
# The type of load balancer (application).
# The security group (alb_sg).
# The subnet in which to place the load balancer (public subnet).
# A tag for the load balancer (app-lb).