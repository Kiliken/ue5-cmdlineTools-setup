@echo off

set thisPath=%cd%

if exist "C:\Program Files\Epic Games\UE_5.5\Engine\Binaries\Win64\UnrealEditor.exe" set unreal="C:\Program Files\Epic Games\UE_5.5\Engine\Binaries\Win64\UnrealEditor.exe"
if exist "D:\Program Files\Epic Games\UE_5.5\Engine\Binaries\Win64\UnrealEditor.exe" set unreal="D:\Program Files\Epic Games\UE_5.5\Engine\Binaries\Win64\UnrealEditor.exe"

if exist "C:\Program Files\Epic Games\UE_5.5\Engine\Binaries\DotNET\UnrealBuildTool\UnrealBuildTool.exe" set unrealBuilder="C:\Program Files\Epic Games\UE_5.5\Engine\Binaries\DotNET\UnrealBuildTool\UnrealBuildTool.exe"

set projExt=*.uproject

pushd %thisPath%
for %%a in (%projExt%) do set projName=%%a
popd


%unreal% "%thisPath%\%projName%" -Game -ProjectName="%projName:~0,-9%" -run=CreateProject -Template="TP_Blank" -Programming
