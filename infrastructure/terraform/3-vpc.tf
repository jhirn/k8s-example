# Add this before the VPC module

# Attempted clean up up resources created by helm deployments preventing a destroy.
# This might work, but untested because feedback loop is 30 minutes =(

# resource "null_resource" "cleanup_load_balancers" {
#   triggers = {
#     cluster_name = var.cluster_name
#     region       = var.aws_region
#   }

#   # This will run before the VPC is destroyed
#   provisioner "local-exec" {
#     when    = destroy
#     command = <<-EOT
#       # Get the cluster endpoint and certificate
#       aws eks update-kubeconfig --name ${self.triggers.cluster_name} --region ${self.triggers.region}

#       # Get and delete the load balancer
#       LB_NAME=$(aws elb describe-load-balancers | jq -r '.LoadBalancerDescriptions[].LoadBalancerName')
#       if [ ! -z "$LB_NAME" ]; then
#         aws elb delete-load-balancer --load-balancer-name $LB_NAME
#       fi

#       # Find and delete the security group
#       SG_ID=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=k8s-elb-*" | jq -r '.SecurityGroups[].GroupId')
#       if [ ! -z "$SG_ID" ]; then
#         aws ec2 delete-security-group --group-id $SG_ID
#       fi

#       # Wait for cleanup to complete
#       sleep 30
#     EOT
#   }
# }

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.cluster_name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  //depends_on = [null_resource.cleanup_load_balancers]
}
