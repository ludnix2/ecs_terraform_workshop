module "rds_instance" {
    source = "cloudposse/rds/aws"
    # Cloud Posse recommends pinning every module to a specific version
    version = "0.35.1"
    namespace                   = "rds"
    stage                       = "prod"
    name                        = "hyeid"
#    dns_zone_id                 = "Z89FN1IW975KPE"
    host_name                   = "hyeid_back"
    security_group_ids          = [aws_security_group.rds.id]
#    ca_cert_identifier          = "rds-ca-2019"
    allowed_cidr_blocks         = [module.vpc.vpc_cidr_block]
    database_name               = "hyeid_back"
    database_user               = "hyeid_user"
    database_password           = "Armenia123"
    database_port               = 3306
    multi_az                    = false
    storage_type                = "gp2"
    allocated_storage           = 20
#    storage_encrypted           = true
    engine                      = "mysql"
    engine_version              = "5.7"
#    major_engine_version        = "5.7"
    instance_class              = "db.t3.micro"
    db_parameter_group          = "mysql5.7"
#    option_group_name           = "mysql-options"
    publicly_accessible         = true
    subnet_ids                  = module.vpc.public_subnets
    vpc_id                      = data.aws_vpc.main.id
#    snapshot_identifier         = "rds:production-2021-05-13-00-00"
    auto_minor_version_upgrade  = true
    allow_major_version_upgrade = false
    apply_immediately           = false
    maintenance_window          = "Mon:03:00-Mon:04:00"
    skip_final_snapshot         = false
    copy_tags_to_snapshot       = true
    backup_retention_period     = 3
    backup_window               = "22:00-03:00"
}

resource "aws_security_group" "rds" {
  name   = "rds-allow-inside-vpc"
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