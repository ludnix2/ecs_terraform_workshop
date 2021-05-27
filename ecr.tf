# ECR Repository

resource "aws_ecr_repository" "hyeid_front" {
  name                 = "hyeid-front"
  image_tag_mutability = "MUTABLE"
    tags = var.comman_tags
}

# Cloudwatch logs

resource "aws_cloudwatch_log_group" "hyeid_front" {
  name = "awslogs-hyeid-front"
    tags = var.comman_tags
}

# ECR Repository

resource "aws_ecr_repository" "hyeid_back" {
  name                 = "hyeid-back"
  image_tag_mutability = "MUTABLE"
    tags = var.comman_tags
}

# Cloudwatch logs

resource "aws_cloudwatch_log_group" "hyeid_back" {
  name = "awslogs-hyeid-back"
    tags = var.comman_tags
}

# ECR Repository

resource "aws_ecr_repository" "hyeid_front_admin" {
  name                 = "hyeid-front-admin"
  image_tag_mutability = "MUTABLE"
    tags = var.comman_tags
}

# Cloudwatch logs

resource "aws_cloudwatch_log_group" "hyeid_front_admin" {
  name = "awslogs-hyeid-front-admin"
    tags = var.comman_tags
}

# ECR Repository

resource "aws_ecr_repository" "hyeid_back_admin" {
  name                 = "hyeid-back-admin"
  image_tag_mutability = "MUTABLE"
    tags = var.comman_tags
}

# Cloudwatch logs

resource "aws_cloudwatch_log_group" "hyeid_back_admin" {
  name = "awslogs-hyeid-back-admin"
    tags = var.comman_tags
}

# ECR Repository

resource "aws_ecr_repository" "hyeid_back_partition" {
  name                 = "hyeid-back-partition"
  image_tag_mutability = "MUTABLE"
    tags = var.comman_tags
}

# Cloudwatch logs

resource "aws_cloudwatch_log_group" "hyeid_back_partition" {
  name = "awslogs-hyeid-back-partition"
    tags = var.comman_tags
}
# ECR Repository

resource "aws_ecr_repository" "hyeid_back_auth" {
  name                 = "hyeid-back-auth"
  image_tag_mutability = "MUTABLE"
    tags = var.comman_tags
}

# Cloudwatch logs

resource "aws_cloudwatch_log_group" "hyeid_back_auth" {
  name = "awslogs-hyeid-back-auth"
    tags = var.comman_tags
}
/*
resource "aws_ecr_lifecycle_policy" "repo_lifecycle_policy" {
  repository = aws_ecr_repository.hyeid_repo.name
  policy     = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 30 days",
            "selection": {
                "tagStatus": "any",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

resource "aws_ecr_repository_policy" "repo_access_policy" {
  repository = aws_ecr_repository.hyeid_repo.name
  policy     = <<EOF
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "adds full ecr access to the demo repository",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
  }
  EOF
}
*/