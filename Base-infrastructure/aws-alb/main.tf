resource "aws_lb" "main" {
  name               = "${var.name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.alb_security_groups
  subnets            = var.subnets.*.id

  enable_deletion_protection = false
}

resource "aws_alb_target_group" "main" {
  name        = "${var.name}-tg"
  port        = var.container_port      
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.main.id
  port              = "80"
  protocol          = "HTTP"

 default_action {
    target_group_arn = aws_alb_target_group.main.id
    type             = "forward"
    }
  }


#resource "aws_alb_listener" "https" {
 # load_balancer_arn = aws_lb.main.id
  #port              = 443
  #protocol          = "HTTPS"

  #ssl_policy      = "ELBSecurityPolicy-2016-08"
  #certificate_arn = var.alb_tls_cert_arn

  #default_action {
    #target_group_arn = aws_alb_target_group.main.id
    #type             = "forward"
  #}
#}