$azSubName = "SubName"
$ADOOrgName = "ADoOrgName"
$AzureDevOpsPAT = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
$tfProjectPath = "<PATH TO TF PROJECT>"
Connect-AzAccount

$azCtx = Set-AzContext -Subscription $azSubName
$azSubObj = Get-AzSubscription -SubscriptionName $azSubName

$azSubAlias = new-azsubscriptionAlias -AliasName $($azSubName.ToLower()) -SubscriptionId $azSubObj.SubscriptionId

$sp = New-AzADServicePrincipal -DisplayName "sp_sub_$($azSubName.ToLower()) -Role "Contributor"
$adApp = Get-AzADApplication -ApplicationId $sp.AppId
$azRoleAssignment = Get-AZRoleAssignment -ObjectId $sp.Id


$AzureDevOpsAuthenicationHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($AzureDevOpsPAT)")) }

$UriOrga = "https://dev.azure.com/$($ADOOrgName)/" 
$projectUri = $UriOrga + "_apis/projects?api-version=7.0"
$project = Invoke-RestMethod -Uri $uriAccount -Method get -Headers $AzureDevOpsAuthenicationHeader

$endpointURI = $UriOrga + "$($project.value.id)/_apis/serviceendpoint/endpoints?api-version=7.0"
$endpoint = Invoke-RestMethod -Uri $endpointURI -Method get -Headers $AzureDevOpsAuthenicationHeader


Write-Output "Importing resources to terraform state..."
Set-Location $tfProjectPath
terraform import module.subscription_az_sub_name.azuread_application.this $adApp.Id
terraform import module.subscription_az_sub_name.azuread_service_principal.this $sp.Id
terraform import module.subscription_az_sub_name.azuredevops_serviceendpoint_azurerm.this $($project.value.id)/$($endpoint.value.id)
terraform import module.subscription_az_sub_name.azurerm_subscription.this $azSubObj.Id
terraform import module.subscription_az_sub_name.azurerm_role_assignment.this $azRoleAssignment.RoleAssignmentId
