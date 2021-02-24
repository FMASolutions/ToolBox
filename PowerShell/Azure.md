### [Home](../Home.md) | [Powershell Home](../PowerShell/Powershell.md)

# Powershell Azure
## Pre-Req
### Azure AD Module Installation
Installing the azure ad module can be done with:
```powershell
Install-Module AzureAD
```
### Connect to Azure AD
Connect and authnticate to Auzre AD Module using:
```powershell
Connect-AzureAD
```
All examples will be using an imported csv into the variable **$csv_input** eg:
```powershell
$csv_input = Get-Content "C:\ExampleUserData\UserEmailList.csv"
```


## Azure AD
### New-AzureADMSInvitation - Without Invitation
Create Azure AD Account based on E-Mail address **without sending an Invite** to the user:
```powershell
#REQUIRED: Replace Tenant ID in URL string
foreach($mail in $csv_input){
    New-AzureADMSInvitation -InvitedUserEmailAddress $mail -InviteRedirectUrl "https://myapps.microsoft.com/?tenantid-XXXXXXX" -SendInvitationMessage $false
}
```

### Get-AzureADUser & Add-AzureADGroupMember
Search for a list of users by E-mail Address, then add the Users to a various groups based on their E-Mail address:
```powershell
$cnt = 0
foreach($mail in $csv_input){
    $cnt++ 
    $user = Get-AzureADUser -Filter "Mail eq '$mail'"
    if($null -eq $user){Write-Host $mail.Mail " not in AAD" -ForegroundColor Red}
    try{
        #REQUIRED: Replace DomainName to search for in E-Mail address & Replace the GroupObjectID
        if($user.Mail.split("@")[1] -eq "SOMEDOMAIN.COM") { $GroupObjectId = "INSERT AZURE OBJECT ID FOR THE GROUP TO BE ADDED HERE"}
        try{
            Write-Host "Adding UPN " $mail " to group with OID" "$GroupObjectId"
            Add-AzureADGroupMember -ObjectId $GroupObjectId -RefObjectId $user.ObjectId
        } catch{}
    } catch{}
}
Write-Host $cnt " addresses processed"
```

### Get-AzureADUser and Export to CSV
Search for a list of AzureAD Users and select the ObjectID (LDAP OID).
Finally export the list to disk in csv format: 
```powershell
foreach($mail in $csv_input){
    Get-AzureADUser -Filter "Mail eq '$mail'" | Select-Object ObjectId, Mail | Export-Csv C:\ExampleUserData\ExportedOID.csv -Append
}
```

### New-AzureADMSInvitation - Resend invitation to user
Resend (or send for the first time) an Azure AD invitation to a user:
```powershell
#REQUIRED: Replace Tenant ID in URL string
foreach($mail in $csv_input){
    New-AzureADMSInvitation -InvitedUserEmailAddress $mail -InviteRedirectUrl "https://myapps.microsoft.com/?tenantid-XXXXXXX" -SendInvitationMessage $true
}
```
### Get-AzureADGroupMember - Get Group Members And Export LDAP OID
Export All Users OID's for a particular group:
```powershell
#REQUIRED: Replace GroupName with required value
Get-AzureADGroup -SearchString "GroupNameHere" | Get-AzureADGroupMember -all $true | Select-Object objectid, displaynamme, mail | Export-Csv -Path C:\ExampleUserData\UsersInGroup.csv
```

# Combined Script
Combined Script to use:
```powershell
throw "Don't hit F5!!!"

Install-Module AzureAD

Connect-AzureAD

$csv = Get-Content "C:\UserDataDirectory\UserEmailList.csv"

#Create Azure AD Account based on E-Mail address without sending an Invite to the user....
#REQUIRED: Replace Tenant ID in URL string
foreach($mail in $csv){New-AzureADMSInvitation -InvitedUserEmailAddress $mail -InviteRedirectUrl "https://myapps.microsoft.com/?tenantid-XXXXXXX" -SendInvitationMessage $false}

#Add Users to specific group based on E-Mail address
$cnt = 0
foreach($mail in $csv){
    $cnt++ 
    $user = get-azureaduser -Filter "Mail eq '$mail'"
    if($null -eq $user){Write-Host $mail.Mail " not in AAD" -ForegroundColor Red}
    try{
        if($user.Mail.split("@")[1] -eq "SOMEDOMAIN.COM") { $GroupObjectId = "INSERT AZURE OBJECT ID FOR THE GROUP TO BE ADDED HERE"}
        try{
            Write-Host "Adding UPN " $mail " to group with OID" "$GroupObjectId"
            Add-AzureADGroupMember -ObjectId $GroupObjectId -RefObjectId $user.ObjectId
        } catch{}
    } catch{}
}
Write-Host $cnt " addresses processed"

#Export OID's of created users
foreach($mail in $csv){get-azureaduser -Filter "Mail eq '$mail'" | Select-Object ObjectId, Mail | Export-Csv C:\UserDataDirectory\ExportedOID.csv -Append}

#Resend Invite Email to users
foreach($mail in $csv){New-AzureADMSInvitation -InvitedUserEmailAddress $mail -InviteRedirectUrl "https://myapps.microsoft.com/?tenantid-XXXXXXX" -SendInvitationMessage $true}

#Export All Users OID for specific Group
Get-AzureADGroup -SearchString "GroupNameHere" | Get-AzureADGroupMember -all $true | Select-Object objectid, displaynamme, mail | Export-Csv -Path C:\UserDataDirectory\UsersInGroup.csv
```