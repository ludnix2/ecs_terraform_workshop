resource "aws_lb" "hyeid_lb" {
  name               = "hyeid-ecs-lb"
  load_balancer_type = "application"
  internal           = false
  subnets            = module.vpc.public_subnets
  security_groups    = [aws_security_group.lb.id]

  tags = var.comman_tags
}

resource "aws_security_group" "lb" {
  name   = "allow-all-lb"
  vpc_id = data.aws_vpc.main.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.comman_tags
}


# Hyeid-Front

resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.hyeid_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hyeid_front_target_group.arn 
  }
}

resource "aws_lb_target_group" "hyeid_front_target_group" {
  name        = "hyeid-front-target-group"
  port        = "80"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.main.id
  deregistration_delay = 60
  health_check {
    path                = "/"
    healthy_threshold   = 3
    unhealthy_threshold = 5
    timeout             = 15
    interval            = 30
    matcher             = "200,301,302,401"
  }
}

# HyeID-Back

resource "aws_lb_target_group" "hyeid_back_target_group" {
  name        = "hyeid-back-target-group"
  port        = "80"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.main.id
  deregistration_delay = 60
  health_check {
    path                = "/"
    healthy_threshold   = 3
    unhealthy_threshold = 5
    timeout             = 15
    interval            = 30
    matcher             = "200,301,302,401"
  }
}

resource "aws_lb_listener_rule" "hyeid_back_listener_rule" {
  listener_arn = "${aws_lb_listener.web-listener.arn}"
  priority = 110

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hyeid_back_target_group.arn
  }

  condition {
    host_header {
      values = ["back-api.hyeid.org"]
    }
  }
}

# HyeID-Back-Admin

resource "aws_lb_target_group" "hyeid_back_admin_target_group" {
  name        = "hyeid-back-admin-target-group"
  port        = "80"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.main.id
  deregistration_delay = 60
  health_check {
    path                = "/"
    healthy_threshold   = 3
    unhealthy_threshold = 5
    timeout             = 15
    interval            = 30
    matcher             = "200,301,302,401"
  }
}

resource "aws_lb_listener_rule" "hyeid_back_admin_listener_rule" {
  listener_arn = "${aws_lb_listener.web-listener.arn}"
  priority = 150

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hyeid_back_admin_target_group.arn
  }

  condition {
    host_header {
      values = ["admin-api.hyeid.org"]
    }
  }
}

# HyeID-Front-Admin

resource "aws_lb_target_group" "hyeid_front_admin_target_group" {
  name        = "hyeid-front-admin-target-group"
  port        = "80"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.main.id
  deregistration_delay = 60
  health_check {
    path                = "/"
    healthy_threshold   = 3
    unhealthy_threshold = 5
    timeout             = 15
    interval            = 30
    matcher             = "200,301,302,401"
  }
}

resource "aws_lb_listener_rule" "hyeid_front_admin_listener_rule" {
  listener_arn = "${aws_lb_listener.web-listener.arn}"
  priority = 130

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hyeid_front_admin_target_group.arn
  }

  condition {
    host_header {
      values = ["admin.hyeid.org"]
    }
  }
}

# HyeID-Back-Partition

resource "aws_lb_target_group" "hyeid_back_part_target_group" {
  name        = "hyeid-back-part-target-group"
  port        = "80"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.main.id
  deregistration_delay = 60
  health_check {
    path                = "/"
    healthy_threshold   = 3
    unhealthy_threshold = 5
    timeout             = 15
    interval            = 30
    matcher             = "200,301,302,401"
  }
}

resource "aws_lb_listener_rule" "hyeid_back_part_listener_rule" {
  listener_arn = "${aws_lb_listener.web-listener.arn}"
  priority = 120
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hyeid_back_part_target_group.arn
  }

  condition {
    host_header {
      values = ["partition-api.hyeid.org"]
    }
  }
}

# HyeID-Back-Auth

resource "aws_lb_target_group" "hyeid_back_auth_target_group" {
  name        = "hyeid-back-auth-target-group"
  port        = "80"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.main.id
  deregistration_delay = 60
  health_check {
    path                = "/"
    healthy_threshold   = 3
    unhealthy_threshold = 5
    timeout             = 15
    interval            = 30
    matcher             = "200,301,302,401"
  }
}

resource "aws_lb_listener_rule" "hyeid_back_auth_listener_rule" {
  listener_arn = "${aws_lb_listener.web-listener.arn}"
  priority = 140

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hyeid_back_auth_target_group.arn
  }

  condition {
    host_header {
      values = ["auth-api.hyeid.org"]
    }
  }
}