
$wc = New-Object Net.WebClient
Add-Type -AssemblyName System.IO.Compression.FileSystem

New-Item -Path "$($PSScriptRoot)\Plugins" -ItemType Directory


# Plugins URLs

# exemple
$ueImGuiDlUrl = "https://github.com/IDI-Systems/UnrealImGui/archive/refs/heads/master.zip"


# Download Plugins

# exemple
Write-Output "[openGL-portable-setup] Downloading UnrealImGUI..."
$wc.DownloadFile($ueImGuiDlUrl, "$($PSScriptRoot)\imgui.zip")


# Extract Plugins

# exemple
Write-Output "[openGL-portable-setup] Extracting UnrealImGUI..."
[System.IO.Compression.ZipFile]::ExtractToDirectory("$($PSScriptRoot)\imgui.zip", "$($PSScriptRoot)\Plugins")


# Extra steps

# exemple (renaming the plugin)
Rename-Item -Path "$($PSScriptRoot)\Plugins\UnrealImGui-master" -NewName "UnrealImGui"

return 0
