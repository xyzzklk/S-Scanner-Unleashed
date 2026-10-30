@echo off
:: Set up console window
color 0A
mode con:cols=83 lines=30   
title S Scanner Unleashed

:: Display welcome banner
echo Created by xyzzklk-a quick, easy-to-use network port scanner built as a wrapper on top of S Scanner by WinEggDrop.

:: Attempt to read config file
if not exist config.ini (
    echo Fatal Error: config.ini not found! ^(Press any key to continue^)
    pause
    exit
)

for /f "usebackq tokens=1,* delims==" %%a in ("config.ini") do (
    set "%%a=%%b"
)

:: Using label style here in case existance of more future config files need to be checked
if not exist %ipRanges% goto :MissingFile
goto :Continue

:MissingFile
echo Oops! Files missing. Gotta check... (press any key to continue)
pause > nul
exit

:Continue
:: Display current config and warning before starting
echo.
echo.
echo.
echo About to perform scan on port %port% with %mode% mode using %threads% threads to all IPs included in ranges specified in %ipRanges%.
echo Open hosts will be saved in %cleanResults% . Note that new results will get appended to any historical scan results, so backup or delete the old result to prevent messing up.
echo Scan logs in %logs%.
echo Press any key to start...
pause>nul

:: Remove any half-processed files from last scan
cls
del Result.txt
del parsedResults1.txt
del parsedResults2.txt
cls
echo Started...
echo.
echo Scan started. Port:%port%; scan mode:%mode%; threads:%threads%...>%logs%

for /f "usebackq tokens=1-2" %%a in ("%ipRanges%") do (
    :: For each range, start scan
    title S Scanner Unleashed—Scanning:%%a %%b
    echo Scanning of IP range %%a %%b has started.
    echo The scanning of the range %%a %%b in %mode% scan mode has started.>>%logs%

    %mode%scan.exe %mode% %%a %%b %port% %threads% /save

    :: Start parsing results
    title S Scanner Unleashed—Parsing Result:%%a %%b
    echo Scanning of IP range %%a %%b has finished. Storing results...
    echo The scanning of the range %%a %%b in %mode% scan mode has finished.Saving...>>%logs%
    echo Raw results saved.>>%logs%
    for /f "eol=- tokens=1 delims= " %%i in (Result.txt) do echo %%i>>parsedResults1.txt
    del Result.txt
    for /f "eol=P tokens=1 delims= " %%i in (parsedResults1.txt) do echo %%i>>parsedResults2.txt
    del parsedResults1.txt
    for /f "eol=S tokens=1 delims= " %%i in (parsedResults2.txt) do echo %%i>>%cleanResults%
    del parsedResults2.txt

    :: Finalise iteration
    echo Clean results saved.>>%logs%
)

title S Scanner Unleashed?Scan finished
echo Scan finished. Pressy any key to exit...
echo Scan finished...>>%logs%
pause>nul
exit