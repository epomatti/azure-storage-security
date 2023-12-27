// connect-with-default-azure-credential.js
// You must set up RBAC for your identity with one of the following roles:
// - Storage Blob Data Reader
// - Storage Blob Data Contributor
import { DefaultAzureCredential } from '@azure/identity';
import { BlobServiceClient } from '@azure/storage-blob';
import * as dotenv from 'dotenv';
dotenv.config();

const accountName = process.env.AZURE_STORAGE_ACCOUNT_NAME as string;
if (!accountName) throw Error('Azure Storage accountName not found');

const blobServiceClient = new BlobServiceClient(
  `https://${accountName}.blob.core.windows.net`,
  new DefaultAzureCredential()
);

async function main() {
  const containerName = 'app1';
  const blobName = 'my-blob';

  const timestamp = Date.now();
  const fileName = `my-new-file-${timestamp}.txt`;

  // create container client
  const containerClient = await blobServiceClient.getContainerClient(
    containerName
  );

  // create blob client
  const blockBlobClient = await containerClient.getBlockBlobClient(blobName);

  const response = await blockBlobClient.uploadFile("sample.txt");

  // download file
  // const downloadResult = await blobClient.downloadToFile(fileName);

  if (response.errorCode) throw Error(response.errorCode);

  // console.log(
  //   `${fileName} downloaded ${response.contentType}, isCurrentVersion: ${downloadResult.isCurrentVersion}`
  // );
}

main()
  .then(() => console.log(`success`))
  .catch((err: unknown) => {
    if (err instanceof Error) {
      console.log(err.message);
    }
  });
