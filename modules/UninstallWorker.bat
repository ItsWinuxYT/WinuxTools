echo off
cls
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "n=%%a" & set "col=%%b")
timeout /t 1 /nobreak > nul
reg delete HKLM\SOFTWARE\WinuxTools /f > nul
rd %homedrive%\PROGRA~1\WinuxTools /s /q > nul

rem End screen
mode 55,25
cls
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
exit