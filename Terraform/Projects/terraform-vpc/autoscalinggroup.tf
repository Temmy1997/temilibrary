resource "aws_autoscaling_group" "app" {
    vpc_zone_identifier = [aws_subnet.publicsubnet1.id, aws_subnet.publicsubnet1.id]
    launch_configuration = aws_launch_configuration.app.id
    min_size             = 2
    max_size             = 4
    desired_capacity     = 2
    
    target_group_arns = [aws_lb_target_group.terraformTG.arn]
    health_check_type         = "EC2"
    health_check_grace_period = 300
    
    tag {
    key                 = "Name"
    value               = "app-instance"
    propagate_at_launch = true
  }
}

# This block creates an Auto Scaling Group (ASG) with the following properties:

# The subnet in which to launch the instances (public subnet).
# The launch configuration to use (app launch configuration).
# The minimum, maximum, and desired number of instances (all set to 2).
# The target group ARN for the load balancer to register the instances with.
# The health check type (EC2) and grace period (300 seconds).
# A tag for the instances (app-instance).