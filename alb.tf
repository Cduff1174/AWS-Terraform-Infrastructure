# ALB
resource "aws_lb" "app" {
    name = "infra1-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [sg-0b89df13e1b896030]
    subnets = module.vpc.public_subnet_ids

    enable_deletion_protection = false
    idle_timeout = 60
    enable_http2 = true
    enable_cross_zone_load_balancing = true

    tags = {
        Name = "my-alb"
    }
}

# ALB Target Group
resource "aws_lb_target_group" "app" {
    name = "infra1-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = module.vpc.vpc.id

    health_check {
        path = "/"
        interval = 30
        timeout = 5
        healthy_threshold = 3
        unhealthy_threshold = 3

    }

    tags = {
        Name = "infra1-target-group"
    }

}

# ALB Listener
resource "aws_lb_listener" "http" {
    load_balancer_arn = "arn:aws:elasticloadbalancing:us-east-1:381491955630:loadbalancer/app/infra1-alb/46d0d1f139c14b3a"
    port = 80
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:381491955630:targetgroup/infra1-target-group/d755beacac0d1b42"
    }

}

resource "aws_lb_target_group_attachment" "web_instance" {
    target_group_arn = aws_lb_target_group.app.arn
    target_id = "i-0b9e458c602cff6ef"
    port = 80
}

