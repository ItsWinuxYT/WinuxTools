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
rd %homedrive%\PROGRA~1\WinuxTools /s /q > nul

rem End screen
endlocal
mode 55,25
cls
call :title
echo.   Thank you for taking your time to try WinuxTools!
echo.
echo.           You can always get this software
echo.           back from Winux's GitHub profile
echo.               if you change your mind
echo.
echo.           Is there anything we can improve?
echo.       %col%[32m[Y] Yes, open the discord support server!
echo.              %col%[1;31m[N] No, close the installer
echo.
choice /c YN /n /m "%n%                         %col%[0;37m> "
set input=%errorlevel%
if "%input%"=="1" start https://discord.gg/GGnfFEyhtQ
exit /b

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

rem Title functions
:title
echo.
echo.
echo %col%[35m     \\\\\            /////   [[[[[[[[[[]]]]]]]]]]%col%[37m
echo %col%[35m      \\\\\          /////    [[[[[[[[[[]]]]]]]]]]%col%[37m
echo %col%[35m       \\\\\        /////            [[[]]]%col%[37m
echo %col%[35m        \\\\\  /\  /////             [[[]]]%col%[37m
echo %col%[35m         \\\\\//\\/////              [[[]]]%col%[37m
echo %col%[35m          \\\\\\//////               [[[]]]%col%[37m
echo %col%[35m           \\\\\/////                [[[]]]%col%[37m
echo.
echo.              An AIO toolbox for your PC.
echo.                https://linktr.ee/winux
echo.
goto :eof
:title2
echo.
echo.
echo.                                            %col%[35m\\\\\            /////   [[[[[[[[[[]]]]]]]]]]%col%[37m
echo.                                             %col%[35m\\\\\          /////    [[[[[[[[[[]]]]]]]]]]%col%[37m
echo.                          Color codes:        %col%[35m\\\\\        /////            [[[]]]%col%[37m          WinuxTools v0.1 (DEV Build)
echo.                          %col%[92mO: %col%[90mEnabled           %col%[35m\\\\\  /\  /////             [[[]]]%col%[37m          An AIO toolbox for your PC
echo.                          %col%[91mO: %col%[90mDisabled           %col%[35m\\\\\//\\/////              [[[]]]%col%[37m          - https://linktr.ee/winux -
echo.                          %col%[96mO: %col%[90mUnavailable         %col%[35m\\\\\\//////               [[[]]]%col%[37m
echo.                                                  %col%[35m\\\\\/////                [[[]]]%col%[37m
echo.
goto :eof