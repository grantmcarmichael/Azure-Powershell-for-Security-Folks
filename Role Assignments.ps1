###################################
# Handy commands for Resource Role Assignments
# Grant Carmichael
###################################

## START USE CASE  - VIEW RESOURCE ROLES ##
# The analyst needs to determine the Role Assignments for an Azure resource
##

# In this case, we'll view a storage account, but if you get the Id for other resources,
# you can see the role assignments for those too
# For the respective storage account, get the attributes
Get-AzureRmStorageAccount -ResourceGroupName "<Resource Group Name>" -AccountName <storage account name>

# Grab the ID and take a peek at the role assignments
Get-AzureRMRoleAssignment -Scope "<the long id of the storage account>"
Get-AzureRMRoleAssignment -Scope "<the long id of the storage account>" | select DisplayName, RoleDefinitionName #pretty version

##
# END USE CASE  - VIEW RESOURCE ROLES ##
##

## START USE CASE  - DETERMINE USER ROLES ##
# The analyst needs to determine what a user has access to
##
Get-AzureRmRoleAssignment -SignInName <the users UPN> -ExpandPrincipalGroups | select DisplayName,SignInName,RoleDefinitionName,ObjectType,scope | ft

##
# END USE CASE  - VIEW RESOURCE ROLES ##
##

## START USE CASE  - CREATE A CUSTOM SECURITY ROLE FOR AZURE ##
# It seems that some actions in Azure, i.e. creating security alerts in Azure Monitor, would be handy
# for the security team.  Unfortunately, it appears you need to be a Contributor to do this, which seems 
# a bit excessive, so you can create custom roles in Azure for your security team.
##

#  First, you may want to search the existing roles for the actions you need.
# Here, we search for roles that allow someone to create new alerts in Azure Monitor.  It returns nothing, which
# means there is no role that explicitly provides that action.
Get-AzureRmRoleDefinition | foreach-Object {Get-AzureRmRoleDefinition $_.Name} | select Name, Actions | Where-Object {$_.Actions -like '*Microsoft.Insights/activityLogAlerts*'}

# View the Role Definition for a particular role
Get-AzureRmRoleDefinition 
Get-AzureRmRoleDefinition "Monitoring Contributor"

# Create a custom role
# Lets say we want to start with the reader role and add to it the Activity Log Alerts Write action
$role = Get-AzureRmRoleDefinition -Name "Reader"
$role.Id = $null
$role.Name = "Custom Security Role"
$role.Description = "Reader Role Plus Extras for Security Folks"
$role.Actions.Add("microsoft.insights/activityLogAlerts/write")
$role.AssignableScopes.Clear()
$role.AssignableScopes.Add("/subscriptions/<subscription id>")
New-AzureRmRoleDefinition -Role $role

# Now add a user to the role
New-AzureRmRoleAssignment -ObjectId <object id of user> -RoleDefinitionName "Custom Security Role" -Scope /subscriptions/<subscription id>

##
# END USE CASE  - VIEW RESOURCE ROLES ##
##