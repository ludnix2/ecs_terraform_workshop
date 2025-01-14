data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami*amazon-ecs-optimized"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon", "self"]
}

resource "aws_security_group" "ec2-sg" {
  name        = "allow-all-ec2"
  description = "allow all"
  vpc_id      = data.aws_vpc.main.id
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

resource "aws_launch_configuration" "lc" {
  name_prefix = "hyeid_ecs_"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  lifecycle {
    create_before_destroy = true
  }
  iam_instance_profile        = aws_iam_instance_profile.ecs_service_role.name
  key_name                    = var.key_name
  security_groups             = [aws_security_group.ec2-sg.id]
  associate_public_ip_address = true
  user_data                   = <<EOF
#! /bin/bash
sudo apt-get update
sudo echo "ECS_CLUSTER=${var.cluster_name}" >> /etc/ecs/ecs.config
EOF
}

resource "aws_autoscaling_group" "asg" {
  name                      = "ASG-${aws_launch_configuration.lc.name}"
  launch_configuration      = aws_launch_configuration.lc.name
  min_size                  = 3
  max_size                  = 3
  desired_capacity          = 3
  health_check_type         = "ELB"
  health_check_grace_period = 60
  vpc_zone_identifier       = module.vpc.public_subnets
  
  protect_from_scale_in = true


  #target_group_arns     = [aws_lb_target_group.hyeid_ui_front_target_group.arn]
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags
    ]
  }
}