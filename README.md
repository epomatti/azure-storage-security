# Azure Storage Security

Implementing advanced security features with Azure Storage services.

Set the initial variables:

```sh
cp config/template.tfvars .auto.tfvars
```

Create the test infrastructure and storage:

```sh
terraform init
terraform apply -auto-approve
```


## Stored Access Policy

https://learn.microsoft.com/en-us/rest/api/storageservices/define-stored-access-policy
