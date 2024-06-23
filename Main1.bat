@echo off
timeout /t 4 /nobreak >nul
set /p response=Do you want to continue? (Y/N): 

if /i "%response%"=="Y" (
    echo You pressed Yes.
) else (
    echo You pressed No.
)
pause
