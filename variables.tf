variable "key_name" {
  type        = string
  default     = "hyeid-terraform"
  description = "The name for ssh key, used for aws_launch_configuration"
}

variable "cluster_name" {
  type        = string
  default     = "ecs-terraform-cluster"
  description = "The name of AWS ECS cluster"
}
variable "comman_tags" {
  type = map(string)
  default = {
    CreatedBy = "Ludwig Markosyan"
    Project   = "HyeID"
    Env       = "Production"
  }
  description = "Our comman tags"

}

