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