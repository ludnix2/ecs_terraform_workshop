module "redis" {
  source = "cloudposse/elasticache-redis/aws"
  # Cloud Posse recommends pinning every module to a specific version
  version = "0.38.0"
  availability_zones         = [
    data.aws_availability_zones.list_available_zones.names[0],
    data.aws_availability_zones.list_available_zones.names[1]
  ]
  namespace                  = "elasticache"
  stage                      = "prod"
  name                       = "hyeid"
#  zone_id                    = var.zone_id
  vpc_id                     = module.vpc.vpc_id
  allowed_security_groups    = [aws_security_group.redis.id]
  subnets                    = module.vpc.public_subnets
  cluster_size               = "1"
  instance_type              = "cache.t2.micro"
  apply_immediately          = true
  automatic_failover_enabled = false
  engine_version             = "4.0.10"
  family                     = "redis4.0"
  at_rest_encryption_enabled = "true"
  transit_encryption_enabled = "true"

  parameter = [
    {
      name  = "notify-keyspace-events"
      value = "lK"
    }
  ]
}

resource "aws_security_group" "redis" {
  name   = "redis-allow-inside-vpc"
  vpc_id = data.aws_vpc.main.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  tags = var.comman_tags
}