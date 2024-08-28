# ALB
resource "aws_lb" "app" {
  name               = "infra1-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  
  # Use the existing public subnet
  subnets            = [aws_subnet.public.id]

  enable_deletion_protection         = false
  idle_timeout                       = 60
  enable_http2                       = true
  enable_cross_zone_load_balancing   = true

  tags = {
    Name = "my-alb"
  }
}

# ALB Target Group
resource "aws_lb_target_group" "app" {
  name     = "infra1-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "infra1-target-group"
  }
}

# ALB Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}