## 
# PowerShell commands for users and groups
# Grant Carmichael
##

###################################
# Handy commands for users
###################################

# Get Azure AD Users
Get-AzureRmADUser -? #for help
Get-AzureRmADUser
Get-AzureADUser

# Get User by User Principal Name
Get-AzureRmADUser -UserPrincipalName {UserPrincipalName}

# Get user by ObjectID
Get-AzureRmADUser -ObjectID <string>

# Search for a user by Display Name
Get-AzureRmADUser -StartsWith "<string>"

# Search for a user by substring 
Get-AzureRmADUser | where UserPrincipalName -like "*<substring>*" 

# Get User's Group Membership
Get-AzureADUser -filter "UserPrincipalName eq '<UPN>'" | Get-AzureADUserMembership | select DisplayName
Get-AzureADUser -filter "UserPrincipalName eq '<UPN>'" | Get-AzureADUserMembership

# List Service Principals
Get-AzureRmADServicePrincipal
Get-AzureRmADServicePrincipal | select DisplayName

# Search Service Principals
Get-AzureRmADServicePrincipal | where DisplayName -like "*<search string>*"

###################################
# Handy commands for groups
###################################

# Get Azure AD Groups
Get-AzureRmADGroup | ft

# Search Azure AD Groups
Get-AzureRmADGroup | where DisplayName -like "*<substring>*"

# Get Group Members
Get-AzureRmADGroupMember -GroupDisplayName <group name>

