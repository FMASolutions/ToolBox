### [Home](../Home.md) | [Powershell Home](../PowerShell/Powershell.md)

# Powershell


# Combined Script
Combined Script to use:
```powershell
#Code to loop around a list of servers and create a job to do any particular task (stop / start services etc....)
$ServerList = @('localhost','127.0.0.1')
$ServiceName = 'TermService'
try{
    foreach($Server in $ServerList) {
        Invoke-Command -AsJob -ComputerName $Server -ScriptBlock {
            #Written this way to show how to use variable declared outside of the "Invoke-Command" cmdlet
            $result = Get-Service $Using:ServiceName
            Write-Host $Using:Server": $result"
        }
    }
    Get-Job | Receive-Job -AutoRemoveJob -Wait
} catch {
    Write-Host "Error: $_"
}
```