module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  #  version        = "3.0.0"
  name = "hyeid"
  cidr = "10.0.0.0/16"
#  azs = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  azs = [
    data.aws_availability_zones.list_available_zones.names[0],
    data.aws_availability_zones.list_available_zones.names[1]
  ]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = var.comman_tags

}

data "aws_vpc" "main" {
  id = module.vpc.vpc_id
}
