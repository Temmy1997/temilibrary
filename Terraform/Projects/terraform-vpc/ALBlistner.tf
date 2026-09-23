resource "aws_lb_listener" "app" {
    load_balancer_arn = aws_lb.terraformLB.arn
    port              = 80
    protocol          = "HTTP"
    
    default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.terraformTG.arn
  }
}

# The ARN of the load balancer.
# The port on which to listen (80).
# The protocol (HTTP).
# The default action is to forward requests to the target group (app).