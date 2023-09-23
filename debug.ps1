Clear-Host

Write-Output "Stating HistoryMe"

$origin = "C:\Users\Sebas\Saved Games\CD Projekt Red\Cyberpunk 2077"
$parentOrigin = Split-Path $origin -Parent
$destination = "D:\HistoryMe"
$allFilesAndFolders = Get-ChildItem -Path $origin -Recurse

foreach ($fileOrFolder in $allFilesAndFolders) {
    
    $newPath= $destination+$fileOrFolder.FullName.ToString().replace($parentOrigin, "")

    if (test-path $newPath) {
        
        #compare the hashes of $fileOrFolder and $newPath
        $hash1 = (Get-FileHash -Path $fileOrFolder.FullName -ErrorAction SilentlyContinue).Hash
        $hash2 = (Get-FileHash -Path $newPath -ErrorAction SilentlyContinue).Hash

        if ($hash1 -ne $hash2) {
            Write-Host "The file $fileOrFolder is different from $newPath"



            copy-item -Path $fileOrFolder.FullName -Destination $newPath -Force
        }
        
    } else {
        copy-item -Path $fileOrFolder.FullName -Destination $newPath -Force
    }
    
    #wait for keypress
    #Read-Host -Prompt "Press Enter to continue"
    
}
