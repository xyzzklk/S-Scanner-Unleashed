@echo off
color 0A
mode con:cols=83 lines=30   
title S Scanner Unleashed
echo Created by xyzzklk！a quick, easy-to-use network port scanner built as a wrapper on top of S Scanner.
set /p port=<port.ini
set /p mode=<scanmode.ini
echo.
echo.
echo.
echo About to perform scan on port %port% with %mode% mode to all IPs included in ranges specified in ip.txt.
echo To change target port, please edit port.ini.
echo To configure scan mode, please change content in scanmode.ini to TCP/SYN.
echo Default port is 3389, mode is TCP.
echo Open hosts will be saved in ips.txt; scan logs in MainLog.txt.
echo Press any key to start...
pause>nul

cls
del Result.txt
del ips.txt
del ips1.txt
del ips2.txt
cls
echo Started...
echo.
echo Scan started. Port:%port%;Scan mode:%mode%...>MainLog.txt

for /f "eol= tokens=1-2 delims= " %%a in (ip.txt) do (
   title S Scanner Unleashed！Scanning:%%a %%b
   echo Scanning of IP range %%a %%b has started.
   echo The scanning of the range %%a %%b in %mode% scan mode has started.>>MainLog.txt
   %mode%scan.exe %mode% %%a %%b %port% 1000 /save
   title S Scanner Unleashed！Parsing Result:%%a %%b
   echo Scanning of IP range %%a %%b has finished. Storing results...
   echo The scanning of the range %%a %%b in %mode% scan mode has finished.Saving...>>MainLog.txt
   echo Raw results saved.>>MainLog.txt
   for /f "eol=- tokens=1 delims= " %%i in (Result.txt) do echo %%i>>ips1.txt
   del Result.txt
   for /f "eol=P tokens=1 delims= " %%i in (ips1.txt) do echo %%i>>ips2.txt
   del ips1.txt
   for /f "eol=S tokens=1 delims= " %%i in (ips2.txt) do echo %%i>>ips.txt
   del ips2.txt
)

title S Scanner Unleashed！Scan finished
echo Scan finished. Pressy any key to exit...
echo Scan finished...>>MainLog.txt
pause>nul
exit