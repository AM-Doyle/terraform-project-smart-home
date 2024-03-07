resource "aws_lb_target_group" "tp-tgs" {

  count = length(var.ec2_names)

  name             = "tp-tg-${var.ec2_names[count.index]}"
  protocol         = var.tg_protocol
  port             = var.tg_port
  protocol_version = var.tg_protocol_version
  vpc_id           = var.vpc_id

  health_check {
    path     = "/health"
    protocol = var.tg_protocol
  }
}

resource "aws_lb_target_group_attachment" "lb_attach_as_001" {

  count = length(var.ec2_ids)

  target_group_arn = aws_lb_target_group.tp-tgs[count.index].arn
  target_id        = var.ec2_ids[count.index]
  port             = 3000
}



resource "aws_lb" "tp_public_load_balancer" {

  name               = "load-balancer-public"
  internal           = false
  load_balancer_type = var.load_balancer_type
  subnets            = var.public_subnet_ids
  security_groups    = var.security_group_ids

}
resource "aws_lb" "tp_private_load_balancer" {

  name               = "load-balancer-private"
  internal           = true
  load_balancer_type = var.load_balancer_type
  subnets            = var.private_subnet_ids
  security_groups    = var.security_group_ids

}

resource "aws_lb_listener" "lb-listener-public" {

  load_balancer_arn = aws_lb.tp_public_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "80"
      protocol    = "HTTP"
      path        = "/api/status"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener_rule" "heating_rule" {

  listener_arn = aws_lb_listener.lb-listener-public.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tp-tgs[0].arn

  }

  condition {
    path_pattern {
      values = ["/api/heating", "/api/heating/*"]
    }
  }
}
resource "aws_lb_listener_rule" "lighting_rule" {

  listener_arn = aws_lb_listener.lb-listener-public.arn
  priority     = 101

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tp-tgs[1].arn

  }

  condition {
    path_pattern {
      values = ["/api/lights", "/api/lights/health", "/api/lights/switch"]
    }
  }
}
resource "aws_lb_listener_rule" "status_rule" {

  listener_arn = aws_lb_listener.lb-listener-public.arn
  priority     = 102

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tp-tgs[2].arn

  }

  condition {
    path_pattern {
      values = ["/api/status/health", "/api/status", "/api/status/register", "/api/status/login", "/api/status/logout"]
    }
  }
}





resource "aws_lb_listener" "lb-listener-private" {

  load_balancer_arn = aws_lb.tp_private_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "80"
      protocol    = "HTTP"
      path        = "/api/auth"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener_rule" "private_auth_rule" {

  listener_arn = aws_lb_listener.lb-listener-private.arn
  priority     = 102

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tp-tgs[3].arn

  }

  condition {
    path_pattern {
      values = ["/api/auth", "/api/auth/login", "/api/auth/register"]
    }
  }
}