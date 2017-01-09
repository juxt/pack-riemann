# Packer-Riemann

Package up Riemann and Riemann-dash into an AMI.

```
packer build -var 'riemann_version=0.2.12' riemann.json
```

# Deploy using Terraform

First export where your private key is (or you'll be asked to type it in)

````
export TF_VAR_riemann_key_path=<where is it?>
```

```
make apply env=<your env file - minus the .tfvars extension>
```
