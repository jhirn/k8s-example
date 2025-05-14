variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Version of the EKS cluster"
  type        = string
  default     = "1.28"
}

# Required
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}

variable "node_groups_general" {
  description = "Node group configuration for the general node group"
  type = object({
    desired_size   = number
    min_size       = number
    max_size       = number
    instance_types = list(string)
    capacity_type  = string
    ami_type       = string
  })
}
