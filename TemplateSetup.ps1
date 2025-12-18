param(
    [Parameter(Mandatory=$true)]
    [string]$OldName,

    [Parameter(Mandatory=$true)]
    [string]$NewName
)

Write-Host "Renaming UE5 project from '$OldName' to '$NewName'..."

# --- 1. Rename .uproject file ---
$oldUProject = "$OldName.uproject"
$newUProject = "$NewName.uproject"

if (Test-Path $oldUProject) {
    if (-not (Test-Path $newUProject)) {
        Rename-Item -Path $oldUProject -NewName $newUProject -Force
        Write-Host "Renamed uproject file."
    } else {
        Write-Host "uproject file already renamed. Skipping."
    }
} else {
    Write-Warning "Could not find $oldUProject"
}

# --- 2. Rename Source/<OldName> folder ---
$oldSourcePath = Join-Path "Source" $OldName
$newSourcePath = Join-Path "Source" $NewName

if (Test-Path $oldSourcePath) {
    if (-not (Test-Path $newSourcePath)) {
        Rename-Item -Path $oldSourcePath -NewName $NewName -Force
        Write-Host "Renamed Source folder."
    } else {
        Write-Host "Source folder already renamed. Skipping."
    }
} else {
    Write-Warning "Could not find Source/$OldName"
}

# --- 3. Rename all files that contain the old name ---
$extensions = "*.cpp","*.h","*.cs","*.Build.cs","*.Target.cs"

foreach ($ext in $extensions) {
    $files = Get-ChildItem -Recurse -Filter $ext
    foreach ($file in $files) {
        if ($file.Name -like "*$OldName*") {
            $newFileName = $file.Name -replace $OldName, $NewName
            $newFilePath = Join-Path $file.DirectoryName $newFileName

            if (-not (Test-Path $newFilePath)) {
                Rename-Item -Path $file.FullName -NewName $newFileName -Force
                Write-Host "Renamed file: $($file.Name)"
            }
        }
    }
}

# --- 4. Replace internal references in all relevant files ---
$allTextFiles = Get-ChildItem -Recurse -Include *.cpp,*.h,*.cs,*.ini,*.uproject,*.Build.cs,*.Target.cs

foreach ($file in $allTextFiles) {
    (Get-Content $file.FullName) |
        ForEach-Object { $_ -replace $OldName, $NewName } |
        Set-Content $file.FullName
}

Remove-Item -Path "$($PSScriptRoot)\Media" -Recurse -Force

Write-Host "Updated internal references in all source files."

Write-Host "✅ Rename complete!"
Write-Host "Next step: regenerate project files:"
Write-Host "UnrealEditor.exe `"$PWD\$newUProject`" -projectfiles"
