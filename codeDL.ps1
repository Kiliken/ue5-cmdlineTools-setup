

$wc = New-Object Net.WebClient
Add-Type -AssemblyName System.IO.Compression.FileSystem

$wc.DownloadFile("https://github.com/Kiliken/ue5-cmdlineTools-setup/archive/refs/heads/main.zip", "$($PSScriptRoot)\main.zip")

[System.IO.Compression.ZipFile]::ExtractToDirectory("$($PSScriptRoot)\main.zip", $PSScriptRoot)

Move-Item "$($PSScriptRoot)\ue5-cmdlineTools-setup-main\*" $PSScriptRoot -Force
Remove-Item "$($PSScriptRoot)\ue5-cmdlineTools-setup-main" -Recurse -Force
Remove-Item "$($PSScriptRoot)\main.zip" -Force
