# XYZ INC Infrastructure

# Cluster setup




## Deployments

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
