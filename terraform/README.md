# Jonathan's Terraform Scripts

Oracle offer __free!__ cloud hosting with an ARM based VM and managed OKE cluster.

Terraform scripts will create:
* Default subnet with some stricut default security groups.
* OKE basic managed k8s cluster.
* One 2 OCPU, 12GB RAM ARM based VM used as k8s worker node.
* Two 1 OCPU, 6GB RAM ARM based VM used as k8s worker node.
