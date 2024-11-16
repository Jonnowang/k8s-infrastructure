# Jonathan's Terraform Scripts

Oracle offer __free!__ cloud hosting with an ARM based VM and managed OKE cluster.

Terraform scripts will create:
* Default subnet with some stricut default security groups.
* OKE basic managed k8s cluster.
* One 2 OCPU, 12GB RAM ARM based VM used as k8s worker node.
* Two 1 OCPU, 6GB RAM ARM based VM used as k8s worker node.

Most folders provide basic scripts to start various Oracle cloud services in terraform.

* `tf-website-infrastructure` - Provides terraform script to start a 4 OCPU ARM compute instance
* `tf-website-cluster` - Provides terraform script with a kubernetes engine with 3 distributed instances.

```bash
terraform init
terraform plan
terraform apply
```
