#Code to loop around a list of servers and create a job to do any particular task (stop / start services etc....)
$ServerList = @('localhost','127.0.0.1')
$ServiceName = 'TermService'
try{
    foreach($Server in $ServerList) {
        Invoke-Command -AsJob -ComputerName $Server -ScriptBlock {
            Get-Service $ServiceName
        }
    }
    Get-Job | Receive-Job -AutoRemoveJob -Wait
} catch {
    Write-Host "Error: $_"
}