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