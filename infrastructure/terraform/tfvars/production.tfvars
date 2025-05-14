cluster_name = "eks-cluster-production"

# Node Group Configuration
node_groups_general = {
  desired_size   = 2
  min_size       = 1
  max_size       = 4
  instance_types = ["t4g.small"]
  capacity_type  = "ON_DEMAND"
  ami_type       = "AL2_ARM_64"
}

# Tags
tags = {
  Environment = "production"
  ManagedBy   = "terraform"
  Project     = "liatrio-exercise"
}
