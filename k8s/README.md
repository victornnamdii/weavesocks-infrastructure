# Kubernetes Deployment

This directory contains the infrastructure for the **Kubernetes** deployment in the [EKS cluster](../aws/). The Kubernetes deployment include the `sock shop` microservice application and it's required resources, `monitoring` tools including Prometheus and Grafana, `alerting` tools including Alertmanager and a `Cluster Issuer` to issue the Let's Encrypt certificate.

## File Structure

The following is an overview of the file structure for this infrastructure:

```
k8s/
├── alerting/
  ├── modules/
    ├── alertmanager/
      ├── data/
      ├── deployment.tf
      ├── service.tf
      ├── outputs.tf
      └── variables.tf
    ├── config/
      ├── data/
      ├── configmap.tf
      ├── ingress.tf
      ├── outputs.tf
      ├── secret.tf
      └── variables.tf
    ├── main.tf
    └── variables.tf
├── cluster-issuer/
  ├── main.tf
  └── variables.tf
├── monitoring/
  ├── modules/
    ├── config/
      ├── data/
      ├── grafana-configmap.tf
      ├── ingress.tf
      ├── namespace.tf
      ├── outputs.tf
      ├── prometheus-configmap.tf
      ├── secret.tf
      └── variables.tf
    ├── tools/
    ├── main.tf
    └── variables.tf
  ├── main.tf
  └── variables.tf
├── sock-shop/
  ├── modules/
  ├── main.tf
  └── variables.tf
├── main.tf/
└── variables.tf/
```
