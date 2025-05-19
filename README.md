# Kubernetes POC for XYZ Inc.

This is repository is a monorepo containing deployable web application along with infrastructure to configure and deploy
to an EKS Cluster on AWS.


It is intended as starting point for app deployment to an EKS cluster with some basic developer QoL and extension points. It mainly relies on interactive scripts but is ripe for further automation.

## Prerequisites

This project assumes the following for development across all components:

- MacOS
- [Homebrew](https://brew.sh/) to install system dependencies
- [mise](https://www.terraform.io/) to manage required software packages and environment

Each subdirectory has it's own README for project specific dependencies. Check the project's `.Brewfile` and `mise.toml` if you'd like to manage these yourself.

## Scripts to rule them all

The components in the monorepo losely follow the [Scripts to Rule them all](https://github.com/github/scripts-to-rule-them-all) convention which provides a common interface for generalized tasks across components. This
enables project specific tasks for setup, execution, deploymennt, etc... to be executed without specific knowledge of
the component.

__The current implementation of this is incomplete and exsits simply to introduce a convention across projects.__

## Usage

1. Deploy infrastructure (See infrastructure/README.md)
2. Deploy webapp (See webapp/README.md)

## Next steps

Here are some of the next steps that can be taken to further improve upon this POC:

- Cluster
  - Add additional availability zones and regions to EKS Cluster
- Deployment
  - Automate version bumping for the application, infrastructure and docker images.
  - Consider use of GitOPS such as ArgoCD or Flux.
  - Consider Blue/Green deployment via RollingUpdate rollover strategy.
- Improved IAM configuration
   - Use Terraform to manage deployer, viewer and and additional service accounts.
   - Configure real users and assume-role for service accounts to track who did what
- Autoscaling
  - Simple min/max
- Integration with ECR (I'm simply using my free DockerHub Account)
- Security
  - Integrate with a secrets manager for storing sensitive information
  - Improve VPC security by further customizing the `vpc` module or manual network routing and seucrity groups.
- Dev QOL
  - webapp
    - Multi stage docker iamge to avoid prebundling Gems and code for iterative development.
    - Make use of .devcontainers installed in Rails project
    - Improvements to local Kubernets deployment if desireable.
  - Infrastructure
    - Monitoring for app helth and deployment statuses
    - Log aggregation.
    - Fine grained modules for VPC/EKS/IAM configuration to improve reuse and reduce state collisions.
    - Consider Terragrunt for improved support across environments.
    - Configure remote state to `s3` for single source of truth. Use `dynamodb` lock to prevent concurrent modifications.

You'll find a number of comment tagged with `TODO` as extension points for the items above and `DISCUSSION` where a decision was made but alternatives exist.

### Known Issues

* `terraform destoy` fails to destroy the VPC because of an ELB resources created by my helm deployment. It may be
be related to: https://github.com/kubernetes/kubernetes/issues/93390.
** To clean up manually destroy ELB and security group manually. I'm not automating this because it's a bit sharp.

```bash
LB_NAME=$(aws elb describe-load-balancers | jq -r '.LoadBalancerDescriptions[].LoadBalancerName')
aws elb delete-load-balancer --load-balancer-name $LB_NAME

SG_ID=aws ec2 describe-security-groups --filters "Name=group-name,Values=k8s-elb-*" | jq -r '.SecurityGroups[].GroupId'
aws ec2 delete-security-group --group-id $SG_ID
```
You should be able to complete terraform destroy after those resources clean themselves up.


* Docker Desktop on Mac was unable to build a `linux/amd64` image. This was resolved by using ARM instances types (`t4g.*`) and `AL2_ARM_64` ami types for the EKS cluster.

* Deprecated argument `inline_policy` in `terraform-eks` module.
