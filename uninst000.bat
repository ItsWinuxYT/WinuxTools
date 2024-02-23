echo off
cls
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "n=%%a" & set "col=%%b")
setlocal EnableDelayedExpansion

rem Restarts the uninstaller as an admin if the registry operation above failed
reg add HKLM\SOFTWARE\WinuxTools\AdminPrev /f > nul
if %errorlevel% neq 0 goto admin
goto confirm

:admin
powershell -NoLogo -Command Start-Process -FilePath %~S0 -Verb RunAs
exit /b

rem Uninstall confirmation
:confirm
mode 49,7
cls
echo.
echo.  %col%[103;30m Do you really want to uninstall WinuxTools? %col%[0;37m
echo.
echo.           %col%[33m(Y) Continue  %col%[32m(N) Cancel
choice /c YN /n /m "%n%                      %col%[37m> "
set input=%errorlevel%
if "%input%"=="1" goto uninst
if "%input%"=="2" exit /b
goto confirm

rem Uninstall WT
:uninst
reg delete HKLM\SOFTWARE\WinuxTools /f > nul
copy "%homedrive%\PROGRA~1\WinuxTools\modules\UninstallWorker.bat" %temp% /V /Y
timeout /t 1 /nobreak > nul
start %temp%\UninstallWorker.bat
exit /b