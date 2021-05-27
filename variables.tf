variable "key_name" {
  type        = string
  default     = "hyeid-terraform"
  description = "The name for ssh key, used for aws_launch_configuration"
}

variable "cluster_name" {
  type        = string
  default     = "hyeid-cluster"
  description = "The name of AWS ECS cluster"
}

variable "hyeid_ui_back_domain_name" {
  type        = string
  default     = "api.hyeid.org"
  description = "Domain name for Hyeid-ui-back app."
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