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

Write-Output "Creating service principal..."

$servicePrincipal = az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/$SubscriptionId/resourceGroups/$ResourceGroup"
Write-Output "SERVICE PRINCIPAAAAAAAAAL!"
Write-Output $servicePrincipal

$json = $servicePrincipal | ConvertFrom-Json
#Expected response: 
# { appId = x, displayName = y, name = z, pass = u, tenant = i  }
# Now you can use this information for whatever you please