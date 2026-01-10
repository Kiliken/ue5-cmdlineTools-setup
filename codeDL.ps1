

$wc = New-Object Net.WebClient
Add-Type -AssemblyName System.IO.Compression.FileSystem

$wc.DownloadFile("https://github.com/Kiliken/ue5-cmdlineTools-setup/archive/refs/heads/main.zip", "$(gl)\main.zip")

[System.IO.Compression.ZipFile]::ExtractToDirectory("$(gl)\main.zip", gl)

Move-Item "$(gl)\ue5-cmdlineTools-setup-main\*" gl -Force
Remove-Item "$(gl)\ue5-cmdlineTools-setup-main" -Recurse -Force
Remove-Item "$(gl)\main.zip" -Force
