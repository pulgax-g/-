@echo off
title skibidi niggas optimizer
chcp 65001>nul                                       
echo school pc doesnt support ascii title
echo do you wanna set it at starup? (y/n)
set /p imput=.%BS% ->
pause
if /I %imput% EQU y goto y
if /I %imput% EQU n goto n
:Y
echo setting at startup
set "startup=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "target=%startup%\pc_optimizer.bat"
if not "%~f0"=="%target%" (
    copy "%~f0" "%target%" >nul
)
:n
echo not setting at startup :c
taskkill /f /im OneDrive.exe >nul 2>&1
echo closing task OneDrive
taskkill /f /im Teams.exe >nul 2>&1
echo closing task Teams
taskkill /f /im Discord.exe >nul 2>&1
echo closing task Discord
taskkill /f /im Spotify.exe >nul 2>&1
echo closing task Spotify 
pause
exit
