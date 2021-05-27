resource "aws_ecs_cluster" "hyeid_cluster" {
  name               = var.cluster_name
  capacity_providers = [aws_ecs_capacity_provider.hyeid.name]
  tags = var.comman_tags
}

resource "aws_ecs_capacity_provider" "hyeid" {
  name = "hyeid-capacity-provider"
  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.asg.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      status          = "ENABLED"
      target_capacity = 85
    }
  }
}

# HyeID-Front

resource "aws_ecs_service" "hyeid_front_service" {
  name            = "hyeid-front-service"
  cluster         = aws_ecs_cluster.hyeid_cluster.id
  task_definition = aws_ecs_task_definition.hyeid_front_task_definition.arn
  desired_count   = 2
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent = 200
  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.hyeid_front_target_group.arn
    container_name   = "hyeid-front"
    container_port   = 80
  }
  # Optional: Allow external changes without Terraform plan difference(for example ASG)
  lifecycle {
    ignore_changes = [desired_count, task_definition]
  }
  launch_type = "EC2"
  depends_on  = [aws_lb_listener.web-listener]
}

resource "aws_ecs_task_definition" "hyeid_front_task_definition" {
  family                = "hyeid-front"
  container_definitions = file("container-definitions/container-def-hyeid-front.json")
  network_mode          = "bridge"
  lifecycle {
    ignore_changes = [container_definitions]
  } 
  tags = var.comman_tags
}

# HyeID-Back

resource "aws_ecs_service" "hyeid_back_service" {
  name            = "hyeid-back-service"
  cluster         = aws_ecs_cluster.hyeid_cluster.id
  task_definition = aws_ecs_task_definition.hyeid_back_task_definition.arn
  desired_count   = 2
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent = 200
  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.hyeid_back_target_group.arn
    container_name   = "hyeid-back"
    container_port   = 8080
  }
  # Optional: Allow external changes without Terraform plan difference(for example ASG)
  lifecycle {
    ignore_changes = [desired_count, task_definition]
  }
  launch_type = "EC2"
  depends_on  = [aws_lb_listener.web-listener]
}


resource "aws_ecs_task_definition" "hyeid_back_task_definition" {
  family                = "hyeid-back"
  container_definitions = file("container-definitions/container-def-hyeid-back.json")
  network_mode          = "bridge"
  lifecycle {
    ignore_changes = [family,network_mode]
  } 
  tags = var.comman_tags
}



# HyeID-Front-Admin

resource "aws_ecs_service" "hyeid_front_admin_service" {
  name            = "hyeid-front-admin-service"
  cluster         = aws_ecs_cluster.hyeid_cluster.id
  task_definition = aws_ecs_task_definition.hyeid_front_admin_task_definition.arn
  desired_count   = 2
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent = 200
  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.hyeid_front_admin_target_group.arn
    container_name   = "hyeid-front-admin"
    container_port   = 80
  }
  # Optional: Allow external changes without Terraform plan difference(for example ASG)
  lifecycle {
    ignore_changes = [desired_count, task_definition]
  }
  launch_type = "EC2"
  depends_on  = [aws_lb_listener.web-listener]
}


resource "aws_ecs_task_definition" "hyeid_front_admin_task_definition" {
  family                = "hyeid-front-admin"
  container_definitions = file("container-definitions/container-def-hyeid-front-admin.json")
  network_mode          = "bridge"
  tags = var.comman_tags
}

# HyeID-Back-Admin

resource "aws_ecs_service" "hyeid_back_admin_service" {
  name            = "hyeid-back-admin-service"
  cluster         = aws_ecs_cluster.hyeid_cluster.id
  task_definition = aws_ecs_task_definition.hyeid_back_admin_task_definition.arn
  desired_count   = 2
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent = 200
  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.hyeid_back_admin_target_group.arn
    container_name   = "hyeid-back-admin"
    container_port   = 8080
  }
  # Optional: Allow external changes without Terraform plan difference(for example ASG)
  lifecycle {
    ignore_changes = [desired_count, task_definition]
  }
  launch_type = "EC2"
  depends_on  = [aws_lb_listener.web-listener]
}


resource "aws_ecs_task_definition" "hyeid_back_admin_task_definition" {
  family                = "hyeid-back-admin"
  container_definitions = file("container-definitions/container-def-hyeid-back-admin.json")
  network_mode          = "bridge"
  tags = var.comman_tags
}


# HyeID-Back-Partition

resource "aws_ecs_service" "hyeid_back_part_service" {
  name            = "hyeid-back-part-service"
  cluster         = aws_ecs_cluster.hyeid_cluster.id
  task_definition = aws_ecs_task_definition.hyeid_back_part_task_definition.arn
  desired_count   = 2
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent = 200
  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.hyeid_back_part_target_group.arn
    container_name   = "hyeid-back-partition"
    container_port   = 8080
  }
  # Optional: Allow external changes without Terraform plan difference(for example ASG)
  lifecycle {
    ignore_changes = [desired_count, task_definition]
  }
  launch_type = "EC2"
  depends_on  = [aws_lb_listener.web-listener]
}


resource "aws_ecs_task_definition" "hyeid_back_part_task_definition" {
  family                = "hyeid-back-partition"
  container_definitions = file("container-definitions/container-def-hyeid-back-partition.json")
  network_mode          = "bridge"
  tags = var.comman_tags
}


# HyeID-Back-Auth

resource "aws_ecs_service" "hyeid_back_auth_service" {
  name            = "hyeid-back-auth-service"
  cluster         = aws_ecs_cluster.hyeid_cluster.id
  task_definition = aws_ecs_task_definition.hyeid_back_auth_task_definition.arn
  desired_count   = 2
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent = 200
  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.hyeid_back_auth_target_group.arn
    container_name   = "hyeid-back-auth"
    container_port   = 8080
  }
  # Optional: Allow external changes without Terraform plan difference(for example ASG)
  lifecycle {
    ignore_changes = [desired_count, task_definition]
  }
  launch_type = "EC2"
  depends_on  = [aws_lb_listener.web-listener]
}


resource "aws_ecs_task_definition" "hyeid_back_auth_task_definition" {
  family                = "hyeid-back-auth"
  container_definitions = file("container-definitions/container-def-hyeid-back-auth.json")
  network_mode          = "bridge"
  tags = var.comman_tags
}