### [Home](../Home.md) | [Powershell Home](../PowerShell/Powershell.md)

# Powershell


# Combined Script
Combined Script to use:
```powershell
function RemoveXMLComments {
    param($fileContent)
    $newContent = ""
    foreach($line in $fileContent){ $newContent += $line + [Environment]::NewLine }
    return $newContent -replace "(?s)<!--.*?-->","" #Regex to remove comment lines
}

function RemoveHashComments {
    param($fileContent)
    $newContent = ""
    foreach($line in $fileContent){
        if(!($line.Trim().StartsWith("#") -or $line.Trim().Length -eq 0)){
            $newContent += $line + [Environment]::NewLine
        }
    }
    return $newContent
}

function RemoveAllBlankLines{
    param($fileContent)
    $newContent = ""
    foreach($line in $fileContent){
        if($line -match '\w' -and $line.Length -gt 0){
            $newContent += $line + [Environment]::NewLine
        }
    }
    return $newContent
}

function CopyAndTidyFile{
    param($source, $dest)

    $fileContent = Get-Content $source -Encoding UTF8
    if($source -like "*.xml"){
        $tidyFile = RemoveXMLComments $fileContent
    } else {
        $tidyFile = RemoveHashComments $fileContent
    }
    
    $output = RemoveAllBlankLines($tidyFile -split [Environment]::NewLine)
    Set-Content -Path $dest -Encoding UTF8 -Value $output
}

CopyAndTidyFile C:\Test\Input.txt C:\Test\Output.txt
```