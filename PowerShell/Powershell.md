### [Home](../Home.md)

# Powershell
## File manipulation
### [Tidy Config Files](../PowerShell/TidyConfigFiles.md)

### Return config lines using a search string
Below needs some testing and notes added.
```powershell
Get-Content D:\Path\To\File.log | ?{($_ | Select-String "STRING TO SEARCH WITHIN THE FILE")}
```

## Azure
### [Azure AD](../PowerShell/Azure.md)

## Logic
### [Loop Over Server List Using Invoke Command As A Job](../PowerShell/ServerLoopInvokeCommandAsJob.md)