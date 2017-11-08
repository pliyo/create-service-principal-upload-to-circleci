Param(
    [Parameter(Mandatory = $true,      Position = 0,  HelpMessage = 'Subscription Id')][ValidateNotNullorEmpty()]
    [String]$SubscriptionId,
    [Parameter(Mandatory = $true,      Position = 1,  HelpMessage = 'Name of your resource group')][ValidateNotNullorEmpty()]
    [String]$ResourceGroup,
    [Parameter(Mandatory = $false,      Position = 2,  HelpMessage = 'Location of your resource group')]
    [String]$Location = "westus",
    [Parameter(Mandatory = $true,      Position = 2,  HelpMessage = 'Your cluster name`')]
    [String]$ClusterName
)

az login

az account set --subscription $SubscriptionId

Write-Output "Creating resource name..."
az group create --name $ResourceGroup --location $Location

$servicePrincipal = az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/$SubscriptionId"
Write-Output "SERVICE PRINCIPAAAAAAAAAL!"
Write-Output $servicePrincipal

$json = $servicePrincipal | ConvertFrom-Json
#Expected response: 
# { appId = x, displayName = y, name = z, pass = u, tenant = i  }

az acs create -n $ClusterName -d somethingtodnsto -g $ResourceGroup --generate-ssh-keys --orchestrator-type kubernetes --service-principal $json.appId --client-secret $json.password 