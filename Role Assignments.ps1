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