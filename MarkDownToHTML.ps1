$MarkDown = ConvertFrom-Markdown -path .\PowerShell\Azure.md
$RawHTML = $MarkDown.Html

$HTML = New-Object -ComObject "HTMLFile"

$src = [System.Text.Encoding]::Unicode.GetBytes($RawHTML)
$HTML.write($src)
$HTML.all.tags("code") | % InnerText

$CustomHTMLHeader=@'
<!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <title>ToolBox Notes</title>
        <style>
</style>
        <link rel="stylesheet" href="../SiteResources/katex.local.min.css"  type="text/css">
        <link rel="stylesheet" href="../SiteResources/katexcopy.local.min.css" type="text/css">
        <link rel="stylesheet" href="../SiteResources/vscodemarkdown.css" type="text/css">
        <link rel="stylesheet" href="../SiteResources/highlight.css" type="text/css">
<style>
            body {
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe WPC', 'Segoe UI', system-ui, 'Ubuntu', 'Droid Sans', sans-serif;
                font-size: 14px;
                line-height: 1.6;
            }
        </style>
        <style>
.task-list-item { list-style-type: none; } .task-list-item-checkbox { margin-left: -20px; vertical-align: middle; }
</style>
        
        <script src="../SiteResources/katex-copy.min.js"></script>
        
    </head>
    <body class="vscode-body vscode-light">
'@

$CustomerHTMLFooter=@'
</body>
</html>
'@
$RawHTML = $RawHTML -replace ".md", ".html"
$RawHTML = $CustomHTMLHeader + $RawHTML + $CustomerHTMLFooter

$RawHTML | Out-File -Encoding utf8 .\Powershell\Auzre_sample_output.html