environment  = "development"
cluster_name = "eks-cluster-${environment}"

# Node Group Configuration
node_groups = {
  general = {
    desired_size   = 1
    min_size       = 1
    max_size       = 1
    instance_types = ["t3.micro"]
    capacity_type  = "ON_DEMAND"
  }
}

# Tags
tags = {
  Environment = "dev"
  ManagedBy   = "terraform"
  Project     = "liatrio-exercise"
}
