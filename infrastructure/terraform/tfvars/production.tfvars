cluster_name = "eks-cluster-production"

# Node Group Configuration
node_groups_general = {
  desired_size   = 1
  min_size       = 1
  max_size       = 1
  instance_types = ["t3.micro"]
  capacity_type  = "ON_DEMAND"
}

# Tags
tags = {
  Environment = "production"
  ManagedBy   = "terraform"
  Project     = "liatrio-exercise"
}
