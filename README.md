# Gitops

General repo for some personal gitops scripts I use to run services. Primarily two things:

1. Terraform code for OCI services kept in `terraform/`. Mainly for spinning up a kubernetes cluster in their free tier.
2. Kubernetes manifests used by flux to reconcile services on the above kubernetes cluster. Kept in `infrastructure/`
