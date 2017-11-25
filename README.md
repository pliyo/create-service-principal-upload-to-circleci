# Creates Service Principal for AKS

# What is a Service Principal?
A Service Principal defines policies and permissions against your applications.
Therefore, it is the person in charge of authentication against your applications in Azure.

# Goal
The aim of this project is to create one service principal to manage your resources, and uplodad that information to your circle ci project, helping you ramp up any


# Requirements
[Azure CLI 2.0](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)


# Usage
You can get your subscription id using `az login` plus `az account`
You can read all about CircleCI api [here](https://circleci.com/docs/api/v1-reference/)


```
.\create-service-principal.ps1.ps1 -SubscriptionId yoursubscriptionId' -ResourceGroup yourresourcegroup -Location yourLocation -GithubAccountName yourGithubAccount -ProjectName yourProjectName -CircleCiToken yourCircleCiToken
```




