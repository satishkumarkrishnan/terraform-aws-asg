
# To create ALB
resource "aws_lb" "test" {
  internal                   = false
  name                       = "tokyo-alb"
  load_balancer_type         = "application"
  security_groups = [module.vpc.vpc_fe_sg, module.vpc.vpc_be_sg]
  #security_groups = [data.aws_security_group.fe_security_id.id, data.aws_security_group.be_security_id.id ]
  #subnets      = [data.aws_subnet.fe_subnet.id, data.aws_subnet.be_subnet.id]
  subnets      = [module.vpc.vpc_fe_subnet.id, module.vpc.vpc_be_subnet.id]
  enable_deletion_protection = true
}
# Target Group Creation
resource "aws_lb_target_group" "target-group" {
  name        = "tokyo-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  #vpc_id      = data.aws_vpc.tokyo_vpc.id
  vpc_id      = module.vpc.vpc_id

  health_check {
    enabled             = true
    interval            = 10
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = {
    Environment = "dev"
  }
}
#ALB Listener
resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.test.arn
  port              = 80
  protocol          = "HTTP"
  depends_on        = [aws_lb_target_group.target-group]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
 autoscaling_group_name = aws_autoscaling_group.tokyo_asg.name
 lb_target_group_arn   = aws_lb_target_group.target-group.arn
 }
