# XYZ INC Infrastructure

This repository manages creating Cloud resources for applications at XYZ Inc.

## Setup

1. Ensure terraform is installed on your system. If you use mise, `script/bootstrap` take care of this for you, but asdf or another solution works fine.

2. Run `script/bootstrap` initialize terraform and create workspaces.

## AWS CLI and deploy user

This app requires you have aws cli installed and set to a profile with adequate permisions. I used the following policy which is sufficient but needs additional refinement.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:*",
                "eks:*",
                "ecr:*",
                "elasticloadbalancing:*",
                "autoscaling:*",
                "cloudwatch:*",
                "logs:*",
                "iam:*",
                "secretsmanager:*",
                "kms:*",
                "tag:GetResources",
                "tag:GetTagKeys",
                "tag:GetTagValues"
            ],
            "Resource": "*"
        }
    ]
}
```

Free free to yolo this on a root account if you wish. 😉



## Terraform wrapper

This repo makes use of `.tfvars` files and workspaces to manage multiple environments. A wrapper has been provided in `script/run_tf` to run interactively which whill handle configuring the proper workspace and arguments to terraform.

```bash
$ script/run_tf plan

run_tf plan                                                                                                                                                                                    13:48:01
Select the Terraform workspace:
1) Development
2) Production
Enter the number (1 or 2): 2
Using workspace: production
Using vars file: tfvars/production.tfvars
~/src/interviews/liatrio/infrastructure/terraform ~/src/interviews/liatrio/infrastructure
Initializing the backend...
Initializing modules...
Initializing provider plugins...
- Reusing previous version of hashicorp/cloudinit from the dependency lock file
- Reusing previous version of hashicorp/aws from the dependency lock file
- Reusing previous version of hashicorp/kubernetes from the dependency lock file
...

```

## Create Infrastructure

Validate your plan with `script/run_tf plan`. If things look ok, ship it with `script/run_tf apply`. This took between 15-25 minutes to complete the first time.


# App Deployments

_We'll use the component's deploy script to manually deploy until a proper CI/GitOps workflow is in place_

1. Ensure the relevant cluster is in your `~/.kube/config`. As an example, we'll use eks-cluster-production. run the folowing script to verify the context is available.

```bash
$ kubectl config get-contexts

CURRENT   NAME                     CLUSTER                                                             AUTHINFO                                                            NAMESPACE
          docker-desktop           docker-desktop                                                      docker-desktop
          eks-cluster-production   arn:aws:eks:us-west-2:528684776489:cluster/eks-cluster-production   arn:aws:eks:us-west-2:528684776489:cluster/eks-cluster-production
*         minikube                 minikube                                                            minikube                                                            default
```

2. If the context is not available, you an add via terraform and targeting the update_kubeconfig resource

```bash
$ run_tf apply -target="null_resource.update_kubeconfig"
```

3. Run `script/deploy` from the app you wish to deploy.

```bash
# in ../webapp
$ script/deploy

Select the kubernetes environment:
1) Local (minikube)
2) Production (Remote)
Enter the number (1 or 2): 2

Switched to context "eks-cluster-production".
Release "wtrn-webapp" has been upgraded. Happy Helming!
NAME: wtrn-webapp
LAST DEPLOYED: Mon May 19 13:20:49 2025
NAMESPACE:
STATUS: deployed
REVISION: 3
TEST SUITE: None
NOTES:
Forward ports by running `minikube tunnel` in a separate window.
After that you can access your app at http://localhost:3000
....

```
