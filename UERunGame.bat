@echo off

set thisPath=%cd%

if exist "C:\Program Files\Epic Games\UE_5.5\Engine\Binaries\Win64\UnrealEditor.exe" set unreal="C:\Program Files\Epic Games\UE_5.5\Engine\Binaries\Win64\UnrealEditor.exe"
if exist "D:\Program Files\Epic Games\UE_5.5\Engine\Binaries\Win64\UnrealEditor.exe" set unreal="D:\Program Files\Epic Games\UE_5.5\Engine\Binaries\Win64\UnrealEditor.exe"

if exist "C:\Program Files\Epic Games\UE_5.5\Engine\Binaries\DotNET\UnrealBuildTool\UnrealBuildTool.exe" set unrealBuilder="C:\Program Files\Epic Games\UE_5.5\Engine\Binaries\DotNET\UnrealBuildTool\UnrealBuildTool.exe"

set projExt=*.uproject

pushd %thisPath%
for %%a in (%projExt%) do set projName=%%a
popd


%unrealBuilder% -ProjectFiles -Project="%thisPath%\%projName%" -Game -Engine -vscode

%unreal% "%thisPath%\%projName%" -log -game -windowed -resx=1280 -resy=720 -ExecCmds="sg.ResolutionQuality=75;sg.ViewDistanceQuality=0;sg.AntiAliasingQuality=0;sg.ShadowQuality=0;sg.PostProcessQuality=0;sg.TextureQuality=0;sg.EffectsQuality=0;sg.FoliageQuality=0"