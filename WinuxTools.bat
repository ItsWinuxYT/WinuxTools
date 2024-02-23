echo off
cls
::You should have received a copy of the GNU GPL v3 license along
::with this program. If not, then see https://gnu.org/licenses/

::This program is open source. You can redistribute and/or modify it under
::the terms of the GNU GPL v3 license as published by the Free Software 
::Foundation, either v3 of the License, or (your option) any later version.

::NOTE: Winux isn't responsible for ANY DAMAGES caused by using this program.
::I recommend creating a restore point before applying any tweaks

::Copyright 2024 © Winux. All rights reserved.

rem Initializes the program
title WinuxTools v1.0
echo Initializing...
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "n=%%a" & set "col=%%b")
for /F "tokens=3*" %%a in ('systeminfo ^| findstr /B /C:"OS Version"') do set "ver=%%a"
reg add "HKCU\Console" /v VirtualTerminalLevel /t REG_DWORD /d 1 /f > nul
if %ver% lss 10 (
    mode 42,20
    cls
    echo.
    echo.  %col%[101;30m    INCOMPATIBLE OPERATING SYSTEM!    %col%[0;31m
    echo.  %col%[1m+------------------------------------+
    echo.  [%col%[0;37m   Your version of Windows is not   %col%[1;31m]
    echo.  [%col%[0;37m   fully supported by WinuxTools.   %col%[1;31m]
    echo.  [%col%[0;37m                                    %col%[1;31m]
    echo.  [%col%[0;37m       You can keep using this      %col%[1;31m]
    echo.  [%col%[0;37m    tool, however some functions    %col%[1;31m]
    echo.  [%col%[0;37m  might break or not work properly  %col%[1;31m]
    echo.  [%col%[0;37m                                    %col%[1;31m]
    echo.  [%col%[0;37m    If you believe this is a bug,   %col%[1;31m]
    echo.  [%col%[0;37m    please make a bug report and    %col%[1;31m]
    echo.  [%col%[0;37m          contact support           %col%[1;31m]
    echo.  +------------------------------------+%col%[0;37m
    echo.   Detected Windows version: %ver%
    echo.
    echo.         %col%[1;31m[X] Exit%col%[37m    %col%[0;33m[Y] Continue
    echo.        %col%[1;34m[S] Discord Support Server%col%[0;37m
    choice /c XYS /n /m "%n%                    > "
    set input=%errorlevel%
    if "%input%"=="1" exit /b
    if "%input%"=="2" rem
    if "%input%"=="3" (
        start https://discord.gg/GGnfFEyhtQ
        exit /b
    )
)
reg add HKLM\SOFTWARE\WinuxTools\AdminPrev /f > nul
if %errorlevel% neq 0 goto admin

rem First-run screen
:frun
for /F "skip=2 tokens=2*" %%a in ('reg query HKLM\SOFTWARE\WinuxTools /v FirstRun') do set "frun=%%b"
if "%frun%"=="0x0" (
    goto start
) else (
    reg add HKLM\Software\WinuxTools /f > nul
    reg add HKLM\Software\WinuxTools\Tweaks /f > nul
    reg add HKLM\Software\WinuxTools\Tweaks /v TDR /t REG_SZ /d "%col%[91m[9]%col%[37m" /f > nul
    reg add HKLM\Software\WinuxTools\Tweaks /v Disk /t REG_SZ /d "%col%[91m[3]%col%[37m" /f > nul
    reg add HKLM\Software\WinuxTools\Tweaks /v CSRSS /t REG_SZ /d "%col%[91m[1]%col%[37m" /f > nul
    reg add HKLM\Software\WinuxTools\Tweaks /v LrFix /t REG_SZ /d "%col%[91m[11]%col%[37m" /f > nul
    reg add HKLM\Software\WinuxTools\Tweaks /v ResOpt /t REG_SZ /d "%col%[91m[4]%col%[37m" /f > nul
    reg add HKLM\Software\WinuxTools\Tweaks /v GameMode /t REG_SZ /d "%col%[91m[10]%col%[37m" /f > nul
    reg add HKLM\Software\WinuxTools\Tweaks /v FastStart /t REG_SZ /d "%col%[91m[2]%col%[37m" /f > nul
    md %homedrive%\PROGRA~1\WinuxTools\modules
    md %homedrive%\PROGRA~1\WinuxTools\backups
    echo Downloading resources. Please wait.
    curl -g -L -# -o "%temp%\WTmodules.zip" "https://cdn.discordapp.com/attachments/1209352107560411216/1209376306404532284/modules.zip?ex=65e6b274&is=65d43d74&hm=847a53d546b877830194eca8ece80bc9c6c349fbae2c6497f5a84116dd9bef14&"
    curl -g -L -# -o "%homedrive%\PROGRA~1\WinuxTools\LICENSE.txt" "https://cdn.discordapp.com/attachments/1209352107560411216/1209376262276120646/LICENSE.txt?ex=65e6b26a&is=65d43d6a&hm=a9af387d4407afa858f6b643a2a905410048497ea0ad0d1800900ea6de6c4955&"
    curl -g -L -# -o "%homedrive%\PROGRA~1\WinuxTools\uninst000.bat" "https://cdn.discordapp.com/attachments/1209352107560411216/1209378562453409903/uninst000.bat?ex=65e6b48e&is=65d43f8e&hm=c156e6061f40d20a6043e5b8a1f69351d16168432b30fe56c61893ecd8dd0a26&"
    if NOT EXIST "%temp%\WTmodules.zip" goto setf
    copy %~S0 %homedrive%\PROGRA~1\WinuxTools\WinuxTools.bat /Y /V > nul
    powershell -NoLogo -Command Expand-Archive -Path "%temp%\WTmodules.zip" -DestinationPath "%homedrive%\PROGRA~1\WinuxTools\modules" -Force
    reg add HKLM\Software\WinuxTools /v FirstRun /t REG_DWORD /d 0 /f > nul
    mode 55,37
    cls
    call :title
    echo.        Welcome to %col%[1;4;35mWinuxTools%col%[0m! %col%[1;4;35mWinuxTools%col%[0m %col%[37mis an
    echo.       open-source toolbox meant to improve your
    echo.         productivity. Here are some important
    echo.               things you need to know:
    echo.
    echo.      %col%[90m1. Winux %col%[4;31mIS NOT RESPONSIBLE%col%[0;90m for %col%[4;31mANY DAMAGE%col%[0;90m
    echo.        done to your PC while using this tool,
    echo.            use anything at your own risk.
    echo.
    echo.      2. A noticable increase in performance is
    echo.                   %col%[4;34mNOT GUARANTEED%col%[0;90m
    echo.
    echo.      3. I recommend contacting our support team
    echo.      if you don't know something or if you have
    echo.           any questions about WinuxTools
    echo.
    echo.      4. This tool is 100% open-source and free.
    echo.        you can freely modify or distribute it
    echo.      under the terms of the GNU GPL V3 license.
    echo.
    echo.            %col%[37mType in %col%[1;33m"%col%[4mI agree%col%[0m"%col%[0;37m to continue
    echo.                (Without quote signs)
    set /p "input=%n%                      > "
    if /I "%input%"=="I agree" (
        call :makerp
        reg add "HKLM\SOFTWARE\WinuxTools" /v FirstRun /t REG_DWORD /d 0 /f > nul
    ) else goto frun
)

rem Restarts the script as an admin if the registry operation above failed
:admin
powershell -NoLogo -Command Start-Process -FilePath %~S0 -Verb RunAs
exit /b

rem Checks registry entries, system devices (Graphics cards, disks, etc.), etc.
:start
setlocal EnableDelayedExpansion
echo Inspecting system specifications...
for /F "tokens=*" %%a in ('powershell -NoLogo -Command "(Get-Disk -Partition (Get-Partition -DriveLetter %homedrive:~0,1%)).Number"') do set sys=%%a
for /F "tokens=*" %%a in ('powershell -NoLogo -Command "(Get-PhysicalDisk).MediaType"') do set disktype=%%a
echo Checking if tweaks has been applied...
for /F "skip=2 tokens=2*" %%a in ('reg query HKLM\SOFTWARE\WinuxTools\Tweaks /v FastStart') do set "fst=%%b"
for /F "skip=2 tokens=2*" %%a in ('reg query HKLM\SOFTWARE\WinuxTools\Tweaks /v GameMode') do set "gmd=%%b"
for /F "skip=2 tokens=2*" %%a in ('reg query HKLM\SOFTWARE\WinuxTools\Tweaks /v ResOpt') do set "res=%%b"
for /F "skip=2 tokens=2*" %%a in ('reg query HKLM\SOFTWARE\WinuxTools\Tweaks /v LrFix') do set "lrf=%%b"
for /F "skip=2 tokens=2*" %%a in ('reg query HKLM\SOFTWARE\WinuxTools\Tweaks /v CSRSS') do set "csr=%%b"
for /F "skip=2 tokens=2*" %%a in ('reg query HKLM\SOFTWARE\WinuxTools\Tweaks /v Disk') do set "dsk=%%b"
for /F "skip=2 tokens=2*" %%a in ('reg query HKLM\SOFTWARE\WinuxTools\Tweaks /v TDR') do set "tdr=%%b"
if NOT EXIST "%homedrive%\PROGRA~1\Adobe\Adobe Lightroom Classic\Lightroom.exe" set "lrfix=%col%[96m[7]%col%[37m"

rem Opens the main UI
:mainmenu
set "input="
cls
mode 55,24
call :title
echo.
echo.
echo.     [1] Optimizations and tweaks     [3] Tools
echo.     [2] Backup and restore           [4] About
echo.     [5] Discord Support server       [6] Updates
echo.
echo. 
choice /c 123456 /n /m "%n%                %col%[4;35mSelect an option%col%[0;35m > %col%[37m"
set input=%errorlevel%
if %input% equ 1 goto tweaks
if %input% equ 2 goto backup
if %input% equ 3 goto tools
if %input% equ 4 goto about
if %input% equ 5 start https://discord.gg/GGnfFEyhtQ
if %input% equ 6 start https://github.com/ItsWinuxYT/WinuxTools/releases/latest
goto mainmenu

rem Optimizations and tweaks UI
:tweaks
mode 144,37
cls
call :title2
echo.
echo.   %col%[1;4;33mSystem Repair and Tweaks%col%[0m
echo.
echo.      %csr% HIGHER PRIORITY CSRSS          %fst% DISABLE FAST STARTUP             %dsk% DISK OPTIMIZATIONS              %res% OPTIMIZE RESOURCES
echo.    %col%[90mHelps to reduce input latency      Fast startup prevents your PC        Optimizes I/O operations on      Optimizes resource consumptions
echo.    by setting the CSRSS process         from fully turning off to            disks and changes a few         by modifying a few filesystem
echo.       priority to real-time.          make the boot process faster.        settings. Also defrags HDDs.          settings and services.%col%[37m
echo.
echo.       [5] REPAIR SYSTEM FILES           [6] REFRESH NETWORK CONFIGS           [7] PRIORITY SEPARATION          [8] ULTIMATE PERF POWERPLAN
echo.    %col%[90mThis will run the System File       This will refresh your network      Determines how the OS assigns      Eliminates micro latencies by
echo.     Checker and other functions        settings and IP configuration       CPU time to processes on this      enabling the hidden Ultimate
echo.    to fix corrupted system files.       Also flushes your DNS cache.           device based on usage            Performance power plan.
echo.
echo.
echo.   %col%[1;4;33mGPU Tweaks%col%[0m                                                              %col%[1;4;33mProgram Tweaks%col%[0m
echo.
echo.        %tdr% MODIFY TDR DELAY                 %gmd% GAMING MODE                  %lrf% LIGHTROOM DENOISE FIX
echo.     %col%[90mPrevents TDR from crashing         Enables the HW-accelerated          Fixes an issue in Adobe Lr's AI
echo.   the graphics driver when doing           GPU scheduler and                denoising feature that causes
echo.        GPU-heavy workloads.            optimizes Windows settings          the system's GPU driver to crash
echo.
echo.
echo.                                                %col%[31m[X] Close the tool      %col%[37m[B] Back to main menu
echo.
set /p input="%n%                                                            %col%[4;35mSelect an option%col%[0;35m > %col%[37m"
echo.
cls
if "%input%"=="1" goto csrss
if "%input%"=="2" goto fstartup
if "%input%"=="3" goto disk
if "%input%"=="4" goto resopt
if "%input%"=="5" call :sysfiles
if "%input%"=="6" goto netop
if "%input%"=="7" goto w32prior
if "%input%"=="8" goto ultperf
if "%input%"=="9" goto tdr
if "%input%"=="10" goto gpu
if "%input%"=="11" goto lrfix
if /I "%input%"=="B" goto mainmenu
if /I "%input%"=="X" exit /b
goto tweaks

rem Configures CSRSS's process priority
:csrss
if "%csr%"=="%col%[91m[1]%col%[37m" (
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 4 /f > nul
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v IoPriority /t REG_DWORD /d 3 /f > nul
    reg add "HKLM\SOFTWARE\WinuxTools\Tweaks" /v CSRSS /t REG_SZ /d "%col%[92m[1]%col%[37m" /f > nul
    set "csr=%col%[92m[1]%col%[37m"
) else (
    reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe" /f > nul
    reg add "HKLM\SOFTWARE\WinuxTools\Tweaks" /v CSRSS /t REG_SZ /d "%col%[91m[1]%col%[37m" /f > nul
    set "csr=%col%[91m[1]%col%[37m"
)
goto tweaks

rem Configure fast startup
:fstartup
if "%fst%"=="%col%[91m[2]%col%[37m" (
    powercfg /H off
    set "fst=%col%[92m[2]%col%[37m"
    reg add "HKLM\SOFTWARE\WinuxTools\Tweaks" /v FastStart /t REG_SZ /d "%col%[92m[2]%col%[37m" /f > nul
) else (
    powercfg /H on
    set "fst=%col%[91m[2]%col%[37m"
    reg add "HKLM\SOFTWARE\WinuxTools\Tweaks" /v FastStart /t REG_SZ /d "%col%[91m[2]%col%[37m" /f > nul
)
goto tweaks

rem Defrags HDDs/Trims SSDs, configures NTFS timestaps and write caching
:disk
if NOT EXIST "%temp%\diskcach.exe" (
    curl -g -L -# -o "%temp%\diskcache.zip" "https://ftp.vector.co.jp/53/41/2791/diskcach_0_5_2.zip"
)
powershell -NoLogo -Command Expand-Archive -Path "%temp%\diskcache.zip" -DestinationPath "%temp%" -Force
if "%dsk%"=="%col%[91m[3]%col%[37m" (
    %temp%\diskcach.exe %sys% -w 1
    fsutil behavior set disablelastaccess 3
    fsutil behavior set disabledeletenotify 0
    fsutil behavior set disablecompression 1
    fsutil behavior set encryptpagingfile 0
    chkdsk %homedrive% /R
    cleanmgr /sageset:50
    cleanmgr /sagerun:50
    set "dsk=%col%[92m[3]%col%[37m"
    reg add "HKLM\SOFTWARE\WinuxTools\Tweaks" /v Disk /t REG_SZ /d "%col%[92m[3]%col%[37m" /f > nul
    defrag %homedrive% /U /V
    call :restart
) else (
    %temp%\diskcach.exe %sys% -w 0
    fsutil behavior set disablelastaccess 2
    fsutil behavior set disabledeletenotify 1
    fsutil behavior set disablecompression 0
    set "dsk=%col%[91m[3]%col%[37m"
    reg add "HKLM\SOFTWARE\WinuxTools\Tweaks" /v Disk /t REG_SZ /d "%col%[91m[3]%col%[37m" /f > nul
    defrag %homedrive% /U /V
    call :restart
)
goto tweaks

rem Resource usage optimizer
:resopt
if "%res%"=="%col%[91m[4]%col%[37m" (
    powershell -NoLogo -Command "Disable-MMAgent -mc"
    fsutil behavior set memoryusage 2
    sc config SensorService start=disabled
    sc config WpcMonSvc start=demand
    sc config WbioSrvc start=demand
    sc config icssvc start=demand
    sc config SCardSvr start=demand
    sc config ScDeviceEnum start=demand
    sc config SCertPropSvc start=demand
    sc config Netlogon start=demand
    sc config FrameServer start=demand
    sc config TabletInputService start=demand
    sc config RemoteRegistry start=demand
    sc config TapiSrv start=demand
    sc config Fax start=demand
    sc config EFS start=demand
    sc config SysMain start=disabled
    if NOT "%disktype%"=="SSD" (
        sc config SysMain start=auto
    )
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsRunInBackground /t REG_DWORD /d 2 /f > nul
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v BackgroundAppGlobalToggle /t REG_DWORD /d 0 /f > nul
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 1 /f > nul
    reg add "HKLM\SOFTWARE\Microsoft\FTH" /v Enabled /t REG_DWORD /d 0 /f > nul
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f > nul
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v DontVerifyRandomDrivers /t REG_DWORD /d 1 /f > nul
    sc stop SensorService
    sc stop WpcMonSvc
    sc stop WbioSrvc
    sc stop icssvc
    sc stop SCardSvr
    sc stop ScDeviceEnum
    sc stop SCertPropSvc
    sc stop Netlogon
    sc stop FrameServer
    sc stop TabletInputService
    sc stop RemoteRegistry
    sc stop TapiSrv
    sc stop Fax
    sc stop EFS
    set "res=%col%[92m[4]%col%[37m"
    reg add "HKLM\SOFTWARE\WinuxTools\Tweaks" /v ResOpt /t REG_SZ /d "%col%[92m[4]%col%[37m" /f > nul
    call :restart
) else (
    powershell -NoLogo -Command "Enable-MMAgent -mc"
    fsutil behavior set memoryusage 1
    sc config SensorService start=auto
    sc config WpcMonSvc start=auto
    sc config WbioSrvc start=auto
    sc config icssvc start=auto
    sc config SCardSvr start=auto
    sc config ScDeviceEnum start=auto
    sc config SCertPropSvc start=auto
    sc config Netlogon start=auto
    sc config FrameServer start=auto
    sc config TabletInputService start=auto
    sc config RemoteRegistry start=auto
    sc config TapiSrv start=auto
    sc config Fax start=auto
    sc config EFS start=auto
    sc config SysMain start=auto
    reg delete "HKLM\SOFTWARE\Microsoft\FTH" /v Enabled /f > nul
	reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v Composition /t REG_DWORD /d 1 /f > nul
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 0 /f > nul
	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v BackgroundAppGlobalToggle /t REG_DWORD /d 1 /f > nul
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsRunInBackground /f > nul
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v DontVerifyRandomDrivers /f > nul
    if NOT "%disktype%"=="SSD" (
        sc config SysMain start=disabled
    )
    set "res=%col%[91m[4]%col%[37m"
    reg add "HKLM\SOFTWARE\WinuxTools\Tweaks" /v ResOpt /t REG_SZ /d "%col%[91m[4]%col%[37m" /f > nul
    call :restart
)
goto tweaks

rem Refresh and reconfigure network settings
:netop
netsh winsock reset
netsh int tcp set supplemental
netsh int tcp set global dca=enabled
netsh int tcp set global netdma=enabled
netsh int tcp set global ecncapability=enabled
ipconfig /release
ipconfig /renew
ipconfig /flushdns
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 10 /f
goto tweaks

rem Unhide the Ultimate Performance power plan
:ultperf
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
start powercfg.cpl
mode 39,10
cls
echo.
echo.  %col%[104;30m       SUCCESSFULLY APPLIED        %col%[0;34m
echo.  %col%[1m+---------------------------------+
echo.  [%col%[0;37m    You should now be able to    %col%[1;34m]
echo.  [%col%[0;37m enable the Ultimate Performance %col%[1;34m]
echo.  [%col%[0;37m    power plan from the Power    %col%[1;34m]
echo.  [%col%[0;37m          Options menu           %col%[1;34m]
echo.  +---------------------------------+%col%[0;37m
echo.       Press any key to continue
pause > nul
goto tweaks

rem Configures the W32 Priority Separator
:w32prior
mode 84,23
cls
echo.
echo.                             %col%[103;30m SELECT OPTIMIZATION TYPE %col%[0;37m
echo.
echo.          %col%[1m[1] 2A HEX %col%[0;32m(RECOMMENDED)                      %col%[1;37m[2] 28 HEX
echo.      %col%[0;90mProvides the best performance on       Provides the best performance on
echo.        games and actively used apps          systems with lots of processes%col%[37m
echo.     Short, Fixed, High foreground boost     Short, Fixed, No foreground boost
echo.
echo.
echo.                                   %col%[1;4;34mShort, Variable%col%[0;1;37m
echo.
echo.         [3] 26 HEX                  [4] 25 HEX                  [5] 24 HEX
echo.    %col%[0;90mHigh foreground boost      Medium foreground boost      No foreground boost%col%[37m
echo.
echo.
echo.                                        %col%[1;4;34mOther%col%[0;1;37m
echo.
echo.                    [6] 29 HEX (SHORT, FIXED)           [7]
echo.                     %col%[0;90mMedium foreground boost       More options%col%[37m
echo.
echo.                               [B] Back to tweaks menu
choice /c 1234567B /n /m "%n%                                         > "
set input=%errorlevel%
if %input%==1 reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 42 /reg:64 /f > nul
if %input%==2 reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 40 /reg:64 /f > nul
if %input%==3 reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /reg:64 /f > nul
if %input%==4 reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 37 /reg:64 /f > nul
if %input%==5 reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 36 /reg:64 /f > nul
if %input%==6 reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 41 /reg:64 /f > nul
if %input%==7 (
    call :unav
    goto w32prior
)
if %input%==8 rem
goto tweaks

rem Modify TDR delay
:tdr
if "%tdr%"=="%col%[91m[9]%col%[37m" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrDelay /t REG_DWORD /d 30 /reg:64 /f > nul
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrDdiDelay /t REG_DWORD /d 30 /reg:64 /f > nul
    reg add "HKLM\SOFTWARE\WinuxTools\Tweaks" /v TDR /t REG_SZ /d "%col%[92m[9]%col%[37m" /f > nul
    set "tdr=%col%[92m[9]%col%[37m"
) else (
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrDelay /f > nul
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrDdiDelay /f > nul
    reg add "HKLM\SOFTWARE\WinuxTools\Tweaks" /v TDR /t REG_SZ /d "%col%[91m[9]%col%[37m" /f > nul
    set "tdr=%col%[91m[9]%col%[37m"
)
goto tweaks

rem Gaming Mode
:gpu
if "%gmd%"=="%col%[91m[10]%col%[37m" (
    for /F "tokens=*" %%a in ('powershell -NoLogo -Command "(Get-CimInstance win32_VideoController).PNPDeviceID | Select-String -Pattern VEN_"') do reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%a\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v MsiSupported /t REG_DWORD /d 1 /f > nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 10 /f > nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NoLazyMode /t REG_DWORD /d 1 /f > nul
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v AlwaysOn /t REG_DWORD /d 1 /f > nul
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f > nul
    reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v Composition /t REG_DWORD /d 0 /f > nul
    reg add "HKLM\SOFTWARE\WinuxTools\Tweaks" /v GameMode /t REG_SZ /d "%col%[92m[10]%col%[37m" /f > nul
    set "gmd=%col%[92m[10]%col%[37m"
) else (
    for /F "tokens=*" %%a in ('powershell -NoLogo -Command "(Get-CimInstance win32_VideoController).PNPDeviceID | Select-String -Pattern VEN_"') do reg delete "HKLM\SYSTEM\CurrentControlSet\Enum\%%a\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v MsiSupported /f > nul
    reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /f > nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NoLazyMode /t REG_DWORD /d 0 /f > nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v AlwaysOn /t REG_DWORD /d 0 /f > nul
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 1 /f > nul
    reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v Composition /t REG_DWORD /d 1 /f > nul
    reg add "HKLM\SOFTWARE\WinuxTools\Tweaks" /v GameMode /t REG_SZ /d "%col%[91m[10]%col%[37m" /f > nul
    set "gmd=%col%[91m[10]%col%[37m"
)
goto tweaks

rem Fixes Lr's AI denoise
:lrfix
if "%lrf%"=="%col%[91m[11]%col%[37m" (
    ren "%appdata%\Adobe\CameraRaw\GPU\Adobe Photoshop Lightroom Classic\Camera Raw GPU Config.txt" "CR_GPU_CONF_old.txt"
    copy "%homedrive%\PROGRA~1\WinuxTools\modules\LrFix.bat" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup" /y
    reg add "HKLM\SOFTWARE\WinuxTools\Tweaks" /v LrFix /t REG_SZ /d "%col%[92m[11]%col%[37m" /f > nul
    set "lrf=%col%[92m[11]%col%[37m"
) else (
    if "%lrf%"=="%col%[96m[11]%col%[37m" (
        mode 47,8
        cls
        echo.
        echo.  %col%[101;30m        COULD NOT APPLY THIS TWEAK!        %col%[0;31m
        echo.  %col%[1m+-----------------------------------------+
        echo.  [%col%[0;37m   Adobe Lightroom is not installed on   %col%[1;31m]
        echo.  [%col%[0;37m              this system.               %col%[1;31m]
        echo.  +-----------------------------------------+%col%[0;37m
        echo.           Press any key to go back
        pause > nul
        goto tweaks
    )
    del "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\LrFix.bat" /q /f > nul
    del "%appdata%\Adobe\CameraRaw\GPU\Adobe Photoshop Lightroom Classic\Camera Raw GPU Config.txt" /q /f > nul
    ren "%appdata%\Adobe\CameraRaw\GPU\Adobe Photoshop Lightroom Classic\CR_GPU_CONF_old.txt" "Camera Raw GPU Config.txt"
    reg add "HKLM\SOFTWARE\WinuxTools\Tweaks" /v LrFix /t REG_SZ /d "%col%[91m[11]%col%[37m" /f > nul
    set "lrfix=%col%[91m[11]%col%[37m"
)
goto tweaks

rem Opens the backup & restore UI
:backup
mode 55,22
cls
call :title
echo.
echo.              [1] Create a restore point
echo.               [2] Opens system restore
echo.                  [3] Advanced backup
echo.
echo.                 (B) Back to main menu
choice /c 123B /n /m "%n%                 %col%[4;35mSelect an option%col%[0;35m >%col%[37m"
set input=%errorlevel%
if %input% equ 1 call :makerp
if %input% equ 2 %windir%\System32\rstrui.exe
if %input% equ 3 (
    set "HKLM=%COL%[92m[+]%COL%[37m"
    set "HKCU=%COL%[92m[+]%COL%[37m"
    set "HKCR=%COL%[92m[+]%COL%[37m"
    set "HKCC=%COL%[92m[+]%COL%[37m"
    set "HKUS=%COL%[92m[+]%COL%[37m"
    set "resp=%COL%[92m[+]%COL%[37m"
    set "prof=%COL%[92m[+]%COL%[37m"
    goto advbackup
)
if %input% equ 4 goto mainmenu
goto backup

rem Advanced backup UI
:advbackup
cls
mode 51,18
echo.
echo.         %col%[103;30m PLEASE SELECT THINGS TO BACK UP %col%[0m
echo.            %col%[92m(+) %col%[90mSelected %col%[91m(-) %col%[90mUnselected
echo.
echo.                  %col%[1;4;34mRegistry Hives%col%[0m 
echo.   %HKLM% 1. Local Machine    %HKCU% 2. Current User
echo.   %HKCR% 3. Classes Root     %HKCC% 4. Current Config
echo.                %HKUS% 5. All Users
echo.
echo.                  %col%[1;4;34mMiscellaneous%col%[0m
echo.           %resp% 6. Create a restore point
echo.           %prof% 7. Backup user profile
echo.
echo.       Press: [N] to continue - [X] to cancel
echo.
choice /C 1234567NX /N /M "%n%                %col%[4;35mSelect an option%col%[0;35m > %col%[37m"
if %errorlevel%==1 (
    if "%HKLM%"=="%col%[92m[+]%col%[37m" set "HKLM=%col%[91m[-]%col%[37m" && goto advbackup
    if "%HKLM%"=="%col%[91m[-]%col%[37m" set "HKLM=%col%[92m[+]%col%[37m" && goto advbackup
)
if %errorlevel%==2 (
    if "%HKCU%"=="%col%[92m[+]%col%[37m" set "HKCU=%col%[91m[-]%col%[37m" && goto advbackup
    if "%HKCU%"=="%col%[91m[-]%col%[37m" set "HKCU=%col%[92m[+]%col%[37m" && goto advbackup
)
if %errorlevel%==3 (
    if "%HKCR%"=="%col%[92m[+]%col%[37m" set "HKCR=%col%[91m[-]%col%[37m" && goto advbackup
    if "%HKCR%"=="%col%[91m[-]%col%[37m" set "HKCR=%col%[92m[+]%col%[37m" && goto advbackup
)
if %errorlevel%==4 (
    if "%HKCC%"=="%col%[92m[+]%col%[37m" set "HKCC=%col%[91m[-]%col%[37m" && goto advbackup
    if "%HKCC%"=="%col%[91m[-]%col%[37m" set "HKCC=%col%[92m[+]%col%[37m" && goto advbackup
)
if %errorlevel%==5 (
    if "%HKUS%"=="%col%[92m[+]%col%[37m" set "HKUS=%col%[91m[-]%col%[37m" && goto advbackup
    if "%HKUS%"=="%col%[91m[-]%col%[37m" set "HKUS=%col%[92m[+]%col%[37m" && goto advbackup
)
if %errorlevel%==6 (
    if "%resp%"=="%col%[92m[+]%col%[37m" set "resp=%col%[91m[-]%col%[37m" && goto advbackup
    if "%resp%"=="%col%[91m[-]%col%[37m" set "resp=%col%[92m[+]%col%[37m" && goto advbackup
)
if %errorlevel%==7 (
    if "%prof%"=="%col%[92m[+]%col%[37m" set "prof=%col%[91m[-]%col%[37m" && goto advbackup
    if "%prof%"=="%col%[91m[-]%col%[37m" set "prof=%col%[92m[+]%col%[37m" && goto advbackup
)
if %errorlevel%==8 goto startbackup
if %errorlevel%==9 goto mainmenu
:startbackup
set cal=%date:/=.%
cls
echo Creating working directories...
rd "%temp%\WTBackup" /s /q > nul
md "%temp%\WTBackup" > nul
echo.
echo Backing up registry entries...
if "%HKLM%"=="%col%[92m[+]%col%[37m" (
    reg export HKLM "%temp%\WTBackup\HKLM.reg" /Y
)
if "%HKCU%"=="%col%[92m[+]%col%[37m" (
    reg export HKCU "%temp%\WTBackup\HKCU.reg" /Y
)
if "%HKCR%"=="%col%[92m[+]%col%[37m" (
    reg export HKCR "%temp%\WTBackup\HKCR.reg" /Y
)
if "%HKCC%"=="%col%[92m[+]%col%[37m" (
    reg export HKCC "%temp%\WTBackup\HKCC.reg" /Y
)
if "%HKUS%"=="%col%[92m[+]%col%[37m" (
    reg export HKU "%temp%\WTBackup\HKUS.reg" /Y
)
if "%resp%"=="%col%[92m[+]%col%[37m" (
    echo.
    echo Creating a restore point...
    powershell -NoLogo -Command Checkpoint-Computer -Description WinuxTools.%cal% -RestorePointType "MODIFY_SETTINGS"
)
if "%prof%"=="%col%[92m[+]%col%[37m" (
    echo.
    echo Backing up user profile...
    powershell -NoLogo -Command "Compress-Archive -Path '%userprofile%' -DestinationPath '%temp%\WTBackup\user.zip' -CompressionLevel NoCompression"
)
echo.
echo Packaging backups...
powershell -NoLogo -Command "Compress-Archive -Path '%temp%\WTBackup' -DestinationPath '%homedrive%\PROGRA~1\WinuxTools\backups\WTBackup_%cal%.zip' -CompressionLevel Optimal"
echo.
echo Cleaning up...
rd %temp%\WTBackup /s /q > nul
for /F "tokens=*" %%a in ('powershell -NoLogo -ExecutionPolicy Unrestricted -Command "%homedrive%\PROGRA~1\WinuxTools\modules\SaveFile.ps1"') do copy "%homedrive%\PROGRA~1\WinuxTools\backups\WTBackup_%cal%.zip" %%a
goto backup

rem Tools menu
:tools
mode 142,22
cls
call :title2
echo.
echo.
echo.           [1] SOFTWARE MANAGER            [2] SCREEN RECORDER           %col%[96m[3]%col%[37m GAME OPTIMIZATIONS             [4] SYSTEM CLEANER
echo.        %col%[90mInstalls/updates practically      Record game clips and           Smoothen your gaming          Cleans up temporary files,
echo.           any software from one          stream using OBS (Open        experience by optimizing         empties recycle bin, and
echo.                 single UI.               Broadcaster Software)       settings and installing mods      removes adware if detected
echo.
echo.                                              %col%[31m[X] Close the tool        %col%[37m[B] Back to main menu
echo.
choice /C 1234XB /N /M "%n%                                                         %col%[4;35mSelect an option%col%[0;35m >%col%[37m"
set input=%errorlevel%
if "%input%"=="1" goto softman
if "%input%"=="2" (
    if NOT EXIST "%homedrive%\PROGRA~1\obs-studio\bin\64bit\obs64.exe" (
        winget install OBSProject.OBSStudio
    )
    set "pwd=%cd%"
    cd /d %homedrive%
    cd "\Program Files\obs-studio\bin\64bit"
    start obs64.exe
    cd %pwd%
)
if "%input%"=="3" call :unav
if "%input%"=="4" call :clean
if "%input%"=="5" exit /b
if "%input%"=="6" goto mainmenu
goto tools

:softman
mode 72,16
cls
echo.
echo.                    %col%[105;30m WINUXTOOLS SOFTWARE MANAGER %col%[0m
echo.
echo.       [1] INSTALL A PROGRAM             [2] UNINSTALL A PROGRAM
echo.     %col%[90mFind and install softwares      Automatically removes softwares
echo.             instantly.                   by entering its name.%col%[37m
echo.
echo.        [3] UPDATE A PROGRAM            [4] CUSTOM WGET ARGUMENTS
echo.    %col%[90mUpdate a program by entering          Open a shell to enter
echo.             its name.                   custom winget arguments
echo.
echo.
echo.          %col%[31m[X] Close the tool     %col%[37m[B] Back to the tools menu
echo.
choice /C 1234XB /N /M "%n%                                > "
set input=%errorlevel%
if "%input%"=="1" goto softinst
if "%input%"=="2" goto softuninst
if "%input%"=="3" goto softupdate
if "%input%"=="4" goto custwget
if "%input%"=="5" exit /b
if "%input%"=="6" goto tools
goto softman

rem Finds and install softwares
:softinst
echo.
set /p name="%n%                 Enter the name of the software > "
mode 120,30
cls
:search
winget search "%name%"
if NOT %errorlevel%==0 (
    echo Press any key to go back 
    pause > nul
    goto softman
)
echo.
set /p name="Enter the ID of the software you want to install > "
if /I "%name%"=="X" goto softman
winget install "%name%"
if NOT %errorlevel%==0 (
    echo Either the name/ID is invalid or an error occured during the installation process.
    echo Please try again or type in %col%[31m[X]%col%[37m to exit.
    goto search
)
timeout /t 1 /nobreak > nul
goto softman

rem Finds and uninstalls a program
:softuninst
echo.
set /p name="%n%              Enter the name/ID of the software > "
mode 120,30
cls
winget uninstall "%name%"
if NOT %errorlevel%==0 (
    echo Press any key to go back 
    pause > nul
    goto softman
)
timeout /t 1 /nobreak > nul
goto softman

rem Finds and updates a program
:softupdate
echo.
set /p name="%n%              Enter the name/ID of the software > "
mode 120,30
cls
winget update "%name%"
if NOT %errorlevel%==0 (
    echo Press any key to go back 
    pause > nul
    goto softman
)
timeout /t 1 /nobreak > nul
goto softman

rem WGet with custom arguments
:custwget
cls
mode 120,30
echo WinuxTools Software Manager WinGet shell
echo Run -? to get help ; Run exit or X to exit this shell
echo.
:a
set /p input="> "
echo.
if /I "%input%"=="X" goto softman
if /I "%input%"=="exit" goto softman
winget %input%
echo.
goto a

:about
mode 55,28
cls
call :title
echo.         +-----------------------------------+
echo.
echo.                Made with love by Winux
echo.           %col%[90mhttps://youtube.com/@TheRealWinux
echo.
echo.                      %col%[1;34mCredits to:%col%[0;37m
echo.            ynaka for the Diskcache utility
echo.       %col%[90mhttps://superuser.com/users/1034389/ynaka
echo.
echo.             %col%[37mslaver01 on BlurBuster forums
echo.               %col%[90mPriority Separator tweaks
echo.
echo.                %col%[37mPress any key to go back
pause > nul
goto mainmenu

rem Settings menu
:settings
mode 144,37
:general
cls
call "%homedrive%\PROGRA~1\WinuxTools\modules\ui\settings-general.bat"
choice /c 1234AB /n /m "%n%"
set input=%errorlevel%

::[---------------------------------------------------------------------------------------------------------------------------]
::[---------------------------------------------------------------------------------------------------------------------------]

rem Setup failed screen
mode 41,11
cls
echo.
echo.  %col%[101;30m    FAILED TO INSTALL WINUXTOOLS    %col%[0;1;31m
echo.  +----------------------------------+
echo.  [%col%[0;37m Seems like you are not connected %col%[1;31m]
echo.  [%col%[0;37m         to the internet.         %col%[1;31m]
echo.  [                                  %col%[1;31m]
echo.  [%col%[0;37m    Please check your internet    %col%[1;31m]
echo.  [%col%[0;37m     connection and try again.    %col%[1;31m]
echo.  +----------------------------------+%col%[0;37m
echo.         Press any key to exit
exit /b

rem Advanced tweaks/tools warning
cls
mode 47,18
cls
echo.
echo.  %col%[101;30m         EXPERIMENTAL/BETA FEATURES        %col%[0;31m
echo.  %col%[1m+-----------------------------------------+
echo.  [%col%[0;37m  These features hasn't been thoroughly  %col%[1;31m]
echo.  [%col%[0;37m   tested and might break your system!   %col%[1;31m]
echo.  [%col%[0;37m                                         %col%[1;31m]
echo.  [%col%[0;37m   %col%[1;4;31mONLY%col%[0;37m use these features if you know   %col%[1;31m]
echo.  [%col%[0;37m   what it does and as with everything   %col%[1;31m]
echo.  [%col%[0;37m         it is %col%[1;4;33mat your own risk.%col%[0;1m         %col%[31m]
echo.  [%col%[0;37m                                         %col%[1;31m]
echo.  [%col%[0;37m  We recommend creating a system backup  %col%[1;31m]
echo.  [%col%[0;37m            before proceeding.           %col%[1;31m]
echo.  +-----------------------------------------+%col%[1;34m
echo.          [B] Open Backup and Restore
echo.                %col%[0;33m[Y] Run anyway%col%[37m
echo.
choice /c BY /n /m "%n%                      > "
set input=%errorlevel%
if %input%==1 goto backup
if %input%==2 goto :eof

rem Restart required screen
:restart
mode 48,11
cls
echo.
echo.  %col%[102;30m              RESTART REQUIRED              %col%[0;32m
echo.  %col%[1m+------------------------------------------+
echo.  [%col%[0;37m  This tweak requires a system reboot to  %col%[1;32m]
echo.  [%col%[0;37m   fully apply. Do you want to restart?   %col%[1;32m]
echo.  [%col%[0;37m                                          %col%[1;32m]
echo.  [%col%[34m   (Y) Restart now    %col%[31m(N) Don't restart   %col%[1;32m]
echo.  [%col%[0;33m        (S) Restart in 10 minutes         %col%[1;32m]
echo.  +------------------------------------------+%col%[0;37m
choice /c YNS /n /m "%n%                      > "
set input=%errorlevel%
cls
if /I %input%==1 (
    shutdown -r -t 0
    exit
)
if /I %input%==2 (
    shutdown -r -t 600 -c "A WinuxTools tweak needs a system reboot to fully apply. Please save any unsaved data. Your PC will reboot in 10 minutes."
    goto :eof
)
if /I %input%==3 goto :eof

rem Makes a restore point
:makerp
powershell -NoLogo -Command Checkpoint-Computer -Description WinuxTools -RestorePointType "MODIFY_SETTINGS"
goto :eof

rem Repair system files
:sysfiles
sfc /scannow
timeout /t 3 /nobreak > nul
DISM /Online /Cleanup-Image /RestoreHealth
timeout /t 3 /nobreak > nul
sfc /scannow
cls
goto :eof

rem Cleaner function
:clean
del "%temp%" /s /q > nul
del "%homedrive%\$RECYCLE.BIN" /s /q > nul
del "%windir%\temp" /s /q > nul
del "%windir%\SoftwareDistribution\Download" /s /q > nul
del "%windir%\Minidump" /s /q > nul
del "%localappdata%\Microsoft\Windows\INetCache\IE" /s /q > nul
del "%localappdata%\Microsoft\Terminal Server Client\Cache" /s /q > nul
del "%windir%\Downloaded Program Files" /s /q > nul
rd "%windir%\Offline Web Pages" /s /q > nul
curl -g -L -# -o "%temp%\clean.exe" "https://adwcleaner.malwarebytes.com/adwcleaner?channel=release"
%temp%\clean.exe /eula /clean
del "%temp%\clean.exe" /q /f > nul
goto :eof

rem Deep Cleaner function
:dclean
icacls "%windir%\Installer\$PatchCache$" /grant "%username%":(F)
del "%windir%\Installer\$PatchCache$" /s /q > nul
icacls "%windir%\ServiceProfiles\NetworkService\AppData\Local\Temp" /grant "%username%":(F)
del "%windir%\ServiceProfiles\NetworkService\AppData\Local\Temp" /s /q > nul
icacls "%windir%\Prefetch" /grant "%username%":(F)
del "%windir%\Prefetch" /s /q > nul
goto :eof

rem Unavailable feature screen
:unav
mode 55,21
call :title
echo.
echo.
echo.        %col%[31m(i) This feature is not available yet%col%[37m
echo.               Press any key to go back
echo.
pause > nul
goto :eof

rem Unavailable tweaks screen
:unavtweak
mode 55,21
call :title
echo.
echo.
echo.        %col%[33m(i) This tweak is not available yet%col%[37m
echo.               Press any key to go back
echo.
pause > nul
goto :eof

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
echo.                          Color codes:        %col%[35m\\\\\        /////            [[[]]]%col%[37m                WinuxTools v1.0
echo.                          %col%[92mO: %col%[90mEnabled           %col%[35m\\\\\  /\  /////             [[[]]]%col%[37m          An AIO toolbox for your PC
echo.                          %col%[91mO: %col%[90mDisabled           %col%[35m\\\\\//\\/////              [[[]]]%col%[37m          - https://linktr.ee/winux -
echo.                          %col%[96mO: %col%[90mUnavailable         %col%[35m\\\\\\//////               [[[]]]%col%[37m
echo.                                                  %col%[35m\\\\\/////                [[[]]]%col%[37m
echo.
goto :eof