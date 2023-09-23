# Create a function to compare and copy files
function CompareAndCopy($source, $target) {
    # Get the files in the source folder
    $sourceFiles = Get-ChildItem -Path $source -Recurse -File
    # Loop through each file
    foreach ($file in $sourceFiles) {
        # Get the relative path of the file
        $relativePath = $file.FullName.Substring($source.Length)
        Write-Output "relativePath: $relativePath"
        #Whait until a key is pressed
        Read-Host -Prompt "Press Enter to continue"

        # Get the corresponding file in the target folder
        $targetFile = Join-Path -Path $target -ChildPath $relativePath
        # Check if the target file exists and is different from the source file
        if ((-not (Test-Path -Path $targetFile)) -or ((Get-FileHash -Path $file.FullName).Hash -ne (Get-FileHash -Path $targetFile).Hash)) {
            # Copy the source file to the target folder and overwrite if exists
            Copy-Item -Path $file.FullName -Destination $targetFile -Force
        }
    }
}


#Show the welcome message "Welcome to HistoryMe"
Clear-Host
Write-Host "Welcome to HistoryMe"

#Read the content of the settings file located in root folder and named settings.json
$settings = Get-Content -Raw -Path .\settings.json | ConvertFrom-Json

#Extract the value of the property "origin-path" from the settings file
$originPath = $settings.'origin-path'

#Extract the value of the property "destination-path" from the settings file
$destinationPath = $settings.'destination-path'

#Verify that Origin Path is an array of paths, and each path exists, and are folders and not files.
if ($originPath -is [array] -and $null -ne $originPath) {
    foreach ($path in $originPath) {
        if (-not (Test-Path $path -PathType Container)) {
            Write-Host "The path $path is not a valid folder"
            exit
        } else {
            Write-Host "The path $path is a valid folder"
        }
    }
} else {
    Write-Host "The origin-path property in settings.json is not an array of paths"
    exit
}

#Verify that Destination Path is a valid path, and it exists, and it is a folder.
if (-not (Test-Path $destinationPath -PathType Container)) {
    Write-Host "The path $destinationPath is not a valid folder"
    exit
} else {
    Write-Host "The path $destinationPath is a valid folder"
}

# Loop forever
while ($true) {
    # Loop through each origin path   
    foreach ($origin in $originPath) {
        # Call the function to compare and copy files
        CompareAndCopy -source $origin -target $destinationPath
    }    
    # Wait 5 seconds
    Start-Sleep -Seconds 5
}
