@echo off

set thisPath=%cd%
set template=TP_Blank

if exist "C:\Program Files\Epic Games\UE_5.5\Templates" set ueTempPath=C:\Program Files\Epic Games\UE_5.5\Templates
if exist "D:\Program Files\Epic Games\UE_5.5\Templates" set ueTempPath=D:\Program Files\Epic Games\UE_5.5\Templates


for %%f in (%cd%) do set projName=%%~nxf


echo Copying template... 
robocopy "%ueTempPath%\%template%" "%cd%" /E /NFL /NDL /NJH /NJS /NC /NS


powershell -ExecutionPolicy Bypass -File TemplateSetup.ps1 -OldName %template% -NewName %projName%

pause