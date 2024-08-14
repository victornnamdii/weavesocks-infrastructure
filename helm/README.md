# Helm Infrastructure

This directory contains the infrastructure for the **Helm** charts installed in the [EKS cluster](../aws/).

## Table of Contents

- [File Structure](#file-structure)
- [Implementation Decisions](#implementation-decisions)
  - [Cert Manager](#cert-manager)
  - [Ingress Controller](#ingress-controller)

## File Structure

The following is an overview of the file structure for this infrastructure:

```
helm/
├── cert-manager.tf
└── ingress-nginx.tf
```

- [cert-manager.tf](cert-manager.tf): Contains the terraform configuration for the `jetsack` repository and the `cert-manager` helm chart which would be installed in our EKS cluster.
- [ingress-nginx.tf](ingress-nginx.tf): Contains the terraform configuration for the `nginx` ingress controller that would be installed in our EKS cluster.

## Implementation Decisions

The decisions i took that brought about this infrastructure is explained below:

### Cert Manager

The Sock Shop app was required to be securely accessible over HTTPS with a Let's Encrypt Certificate. This was implemented using jetsack's cert-manager. Cert manager can be easily installable using `helm` according to their documentation. So, a terraform `helm_release` resource was created for this purpose.

The configuration for this can be found at [cert-manager.tf](cert-manager.tf).

- The repository's URL was passed through the `repository` attribute.
- The name of the chart was passed through the `chart` attribute.
- The namespace where the cert manager was to installed was specified through `namespace` attribute.
- The `create_namespace` attribute was set to `true` to allow helm create the namespace
- The cert manager version was passed through the `version` attribute.
- CustomResourceDefinition was enabled using `name  = "crds.enabled"` and `value = "true"` in the `set` attribute.

All values above were gotten from the certmanager documentation.

### Ingress Controller

Some certain services in our [Kubernetes deployment](../k8s/) would require external HTTP and HTTPS access. For this to happen, **Ingress** resources were used for those services. For external traffic to be routed to the rules defined in the Ingress resources, an `Ingress controller` is required to be installed in the cluster.

My preferred ingress controller was the `nginx` ingress controller and this was also easily installable with Helm, so, a terraform `helm_release` resource was created for this purpose.

The configuration for this can be found at [ingress-nginx.tf](ingress-nginx.tf).

- The repository's URL was passed through the `repository` attribute.
- The name of the chart was passed through the `chart` attribute.
- The namespace where the cert manager was to installed was specified through `namespace` attribute.
- The `create_namespace` attribute was set to `true` to allow helm create the namespace
- The nginx ingress controller version was passed through the `version` attribute.

This part sets the name of the ingress class which would then be set on the other ingress resources sothey would be connected:

```
set {
    name  = "controller.ingressClassResource.name"
    value = "external-ingress-nginx"
  }
```

This part allows metrics to be collected through the ingress:

```
set {
    name  = "controller.metrics.enabled"
    value = "true"
  }
```

This part makes sure a `network` load balancer was used instead of a classic load balancer:

```
set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "nlb"
  }
```
