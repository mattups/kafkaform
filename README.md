# kafkaform
Just an exercise with Terraform and Ansible to deploy a Kafka cluster on Azure. Obviously this is not a production-grade implementation :)

## Preparation
Create a service principal to interact with your Azure subscription. You can have instructions [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret)

Set the environment variables, in this way terraform will be able to automatically use them when initializing and you don't have to declare them in the provider's configuration.

```
$ export ARM_CLIENT_ID="00000000-0000-0000-0000-000000000000"
$ export ARM_CLIENT_SECRET="00000000-0000-0000-0000-000000000000"
$ export ARM_SUBSCRIPTION_ID="00000000-0000-0000-0000-000000000000"
$ export ARM_TENANT_ID="00000000-0000-0000-0000-000000000000"
```

_Make sure you also have `az` cli installed on your system._

## Building the infra
The code for building infrastructure is in `/terraform` folder.

Take a look at `variables.tf` file and configure as you wish.

Once ready, apply the usual workflow for terraform:
```
terraform init
terraform plan
terraform apply
```
### Connecting to the created vms
During the execution plan an ssh keypair was generated with the local provider. You can retrieve it from the state with:
```
terraform show -json | \
jq -r '.values.root_module.resources[].values | select(.private_key_pem) |.private_key_pem' \
> ~/.ssh/terraform_private_key.pem
```
Fix its permissions:
```
chmod 600 ~/.ssh/terraform_private_key.pem
```

And then if everything is ok connect to the instance:
```
ssh -i ~/.ssh/terraform_private_key.pem kafka-admin@public_dns_name
```
_Note that you have to use the `kafka_admin_user` you declared in `variables.tf` and the public ip address created by Terraform and outputted at the end of the plan_ 

# Use Ansible to provision the Kafka cluster
Configure the `hosts.yml` file in the `ansible` folder as you wish.
You can find more detailed info on their [documentation](https://docs.confluent.io/ansible/current/overview.html), specifcally on [how to configure you hosts.yml file](https://docs.confluent.io/ansible/current/ansible-prepare.html)
Take a look at my `hosts.yml` file for a reference if you need, but it's already pre-configured to run as it is after the deployment by terraform.

Be sure also to enable `hash_merge` for ansible. Quick way with `export ANSIBLE_HASH_BEHAVIOUR=merge`

Once ready, execute a ping test to see if machines are available:
`ansible -i /path/to/hosts.yml all -m ping`

Once ready go for it with:
`ansible-playbook -i hosts.yml confluent.platform.all`.

Sit, wait, and your Kafka cluster will be ready in a few minutes!

Hope you found this helpful