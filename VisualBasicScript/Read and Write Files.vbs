Set objFSO=CreateObject("Scripting.FileSystemObject")

outFile="C:\Test\Outputfile.txt"
Set objFile = objFSO.CreateTextFile(outFile,True)
objFile.Write "test string" & vbCrLf
objFile.Close


Set objFile = objFSO.OpenTextFile(strFile)
Do Until objFile.AtEndOfStream
    strLine= objFile.ReadLine
    Wscript.Echo strLine
Loop
objFile.Close