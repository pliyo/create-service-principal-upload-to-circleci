# Creates Service Principal for AKS

# What is a Service Principal?
A Service Principal defines policies and permissions against your applications.
Therefore, it is the person in charge of authentication against your applications in Azure.

# Goal
The aim of this project is to retrieve the information from the Service Principal once created, so it could be reused somewhere else.
For example, to store the `appId`, `displayName`, `name`, `pass` or `tenant` somewhere after creation. 

You can read about how to do that from here:
https://docs.microsoft.com/en-us/azure/container-service/kubernetes/container-service-kubernetes-service-principal

# Requirements
[Azure CLI 2.0](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)


# Usage
You can get your subscription id using `az login` plus `az account`

```
.\ContainerAutomation.ps1 -SubscriptionId yoursubscriptionId' -ResourceGroup yourresourcegroup -ClusterName yourclustername
```








