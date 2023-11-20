@echo off
rem Run the script as an administrator
runas /user:administrator /savecred "%~dpnx0"
rem Get the total amount of RAM in KB
for /f "tokens=2 delims==" %%a in ('wmic computersystem get TotalPhysicalMemory /format:value') do set RAM=%%a
set /a RAM=%RAM% / 1024
rem Set the registry key SvcHostSplitThresholdInKB to the amount of RAM in KB
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v SvcHostSplitThresholdInKB /t REG_DWORD /d %RAM% /f
rem Restart the computer
shutdown /r /t 0
