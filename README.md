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

## Networking

### Service Endpoints

Connection via Service Endpoints where subnet should have `Microsoft.Storage` endpoint assigned. 

### Private Link

Check the private DNS zones for [Storage][1].


[1]: https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns#storage
