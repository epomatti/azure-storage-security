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

## Performance

From the documentation:

> - **Standard** allows you to have any data service (Blob, File, Queue, Table) and uses magnetic disk drives.
> - **Premium** provides more services for storing data. For example, storing unstructured object data as block blobs or append blobs, and specialized file storage used to store and create premium file shares. These storage accounts use solid-state drives (SSD) for storage.

Additional comment on number of storages:

> Typically, your data diversity, cost sensitivity, and tolerance for management overhead determine the number of storage accounts you need.

## Common usages

- Browser uploads
- Distributed access
- Streaming data
- Archiving and recovery
- Application access

## Public Access Level

- **Private**: (Default) Prohibit anonymous access to the container and blobs.
- **Blob**: Allow anonymous public read access for the blobs only.
- **Container**: Allow anonymous public read and list access to the entire container, including the blobs.

## Access Tiers

Check the documentation: [Access Tiers][3]

## Blob types

- Block: Binary or text files
- Append: Logs
- Page: Disks

## Authorization

Check the documentation for [authorization options][4].

## User Delegated SAS

Must use the REST API.

## Stored Access Policy

Must use the REST API.

https://learn.microsoft.com/en-us/rest/api/storageservices/define-stored-access-policy

## Networking

### Service Endpoints

Connection via Service Endpoints where subnet should have `Microsoft.Storage` endpoint assigned. 

### Private Link

Check the private DNS zones for [Storage][1].


[1]: https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns#storage
[2]: https://learn.microsoft.com/en-us/training/modules/create-azure-storage-account/2-decide-how-many-storage-accounts-you-need
[3]: https://learn.microsoft.com/en-us/training/modules/configure-blob-storage/4-create-blob-access-tiers
[4]: https://learn.microsoft.com/en-us/training/modules/configure-storage-security/2-review-strategies
