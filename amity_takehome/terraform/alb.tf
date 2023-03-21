# Application Load balancer for autoscaling
# Create a target group for the service
# To complete this I would add an autoscaling group, launch configurations, and listener rules
# but I'm doing this for free and I don't want to pay for an ALB in my personal
# account so I will stop here. 

resource "aws_lb_target_group" "service" {
  name     = "service"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.molecular_app.id
}

resource "aws_lb_target_group" "nats" {
  name     = "service"
  port     = 4222
  protocol = "tcp"
  vpc_id   = aws_vpc.molecular_app.id
}


# Create the Application Load Balancer
resource "aws_lb" "molecular_app_lb" {
  name               = "molecular-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = ["ap_public_1"]
}

# Create a listener for the ALB
resource "aws_lb_listener" "molecular_app_lb_listener" {
  load_balancer_arn = aws_lb.molecular_app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.service.arn
  }
}
