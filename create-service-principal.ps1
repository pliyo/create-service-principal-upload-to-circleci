Param(
    [Parameter(Mandatory = $true,      Position = 0,  HelpMessage = 'Subscription Id')][ValidateNotNullorEmpty()]
    [String]$SubscriptionId,
    [Parameter(Mandatory = $true,      Position = 1,  HelpMessage = 'Name of your resource group')][ValidateNotNullorEmpty()]
    [String]$ResourceGroup,
    [Parameter(Mandatory = $true,      Position = 2,  HelpMessage = 'Location of your resource group')][ValidateNotNullorEmpty()]
    [String]$Location,
    [Parameter(Mandatory = $true,      Position = 3,  HelpMessage = 'Github account name')][ValidateNotNullorEmpty()]
    [String]$GithubAccountName,
    [Parameter(Mandatory = $true,      Position = 4,  HelpMessage = 'Project Name')][ValidateNotNullorEmpty()]
    [String]$ProjectName,
    [Parameter(Mandatory = $true,      Position = 5,  HelpMessage = 'Project name')][ValidateNotNullorEmpty()]
    [String]$CircleciToken
) 

az login

Write-Output "Setting your SubscriptionId as your current subscription"
az account set --subscription $SubscriptionId
Write-Output "You are in:"
az account show
Write-Output "Creating resource name..."
az group create --name $ResourceGroup --location $Location
Write-Output "Creating service principal..."
$response = az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/$SubscriptionId"
$servicePrincipal = $response | ConvertFrom-Json
#Expected response: 
# { 
#  "appId":"x", 
#  "displayName":"y",
#  "name":"z",
#  "password":"p",
#  "tenant":"i"
#  }

$servicePrincipalName = @{
        name='SERVICE_PRINCIPAL'
        value=$servicePrincipal.name
} | ConvertTo-Json

$servicePrincipalPassword = @{
    name='SERVICE_PRINCIPAL_PASS'
    value=$servicePrincipal.password
} | ConvertTo-Json

$servicePrincipalTenant = @{
    name='SERVICE_TENANT'
    value=$servicePrincipal.tenant
} | ConvertTo-Json

Write-Output "Sending your tokens to CircleCi..."

$posturl = "https://circleci.com/api/v1.1/project/github/$GithubAccountName/$ProjectName/envvar?circle-token=$CircleciToken"

Invoke-webrequest -Uri $posturl -Method Post -Body $servicePrincipalName -ContentType 'application/json'
Invoke-webrequest -Uri $posturl -Method Post -Body $servicePrincipalPassword -ContentType 'application/json'
Invoke-webrequest -Uri $posturl -Method Post -Body $servicePrincipalTenant -ContentType 'application/json'
