@echo off

setlocal EnableDelayedExpansion

REM Define PowerShell script as a multi-line string
set "psCmd=powershell.exe -NoProfile -Command ^"
set "psCmd=!psCmd! Add-Type -AssemblyName PresentationFramework; ^"
set "psCmd=!psCmd! $Buttons = [System.Windows.MessageBoxButton]::YesNoCancel; ^"
set "psCmd=!psCmd! $Result = [System.Windows.MessageBox]::Show('Do you want to continue?', 'Prompt', $Buttons); ^"
set "psCmd=!psCmd! if ($Result -eq [System.Windows.MessageBoxResult]::Yes) { ^"
set "psCmd=!psCmd! [System.Windows.MessageBox]::Show('You pressed Yes.', 'Prompt') } ^"
set "psCmd=!psCmd! elseif ($Result -eq [System.Windows.MessageBoxResult]::No) { ^"
set "psCmd=!psCmd! [System.Windows.MessageBox]::Show('You pressed No.', 'Prompt') } ^"
set "psCmd=!psCmd! else { ^"
set "psCmd=!psCmd! [System.Windows.MessageBox]::Show('You pressed Maybe.', 'Prompt') }"

REM Execute PowerShell script
%psCmd%

endlocal
