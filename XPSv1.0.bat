::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFDpQQQ2MNXiuFLQI5/rHy++UqVkSRN4bXIDo5j1D1Gf2FMMNvhHFMEYJy5taMDJbezeyazMdqmtnr2GxJdKZ/QbiRSg=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSTk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQJhZksaHErSXA==
::ZQ05rAF9IBncCkqN+0xwdVsFAlTMbCXqZg==
::ZQ05rAF9IAHYFVzEqQIoMQFORwiJu6B1g1rfbgEwaQVoJ7TVNA==
::eg0/rx1wNQPfEVWB+kM9LVsJDDyyD33rSOVS7fD+jw==
::fBEirQZwNQPfEVWB+kM9LVsJDBybJnGxCr5c2Ofp+6q0oUwTWuctGA==
::cRolqwZ3JBvQF1fEqQK08PvSgNoFyLo/4GWbFDR8MhsAebGbtDm4tk7Dw66UK+wYbp0u8Uz3UaasHS31i+G8bZRCpYnbRuu7fuFj0kFca4gqhc1mJc3Z0OObaOYpRKjbgrM=
::dhA7uBVwLU+EWNxiJMXM9JyJvYNZwAs=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATE100gMQldSwyWfMlzVOVOuKjj9vCdqUEWGqIedIObyL2JKPQAqlfhZpM/wH9e1qs=
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFDpQQQ2MNXiuFLQI5/rHy++UqVkSRN4bXIDo5j1D1Gf2FMMNvhHFMEYJy5NVMANBZAigYgQEpnxWhWeEOcmZoTP5U1KT7Uc7K2pmk1DTjSU1ZcFUovMwxXHwrAP6h6Bw
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
color 0A
mode con:cols=83 lines=30   
title xyzzklk端口扫描工具V1.0-准备就绪
echo 本工具作者xyzzklk，内核源自S扫描器。
echo Copyright (c) 2020 xyzzklk. All rights reserved.
set /p port=<port.ini
set /p mode=<scanmode.ini
echo.
echo.
echo.
echo 即将进行对ip.txt中所有IP段内IP的%port%端口进行%mode%模式端口扫描。
echo 如需更改扫描端口，请修改port.ini中的端口为指定端口号。
echo 如需更换扫描模式，请更换scanmode.ini中的内容为TCP或SYN。
echo 默认扫描端口为3389，模式为TCP。
echo 扫描结果将储存在ips.txt中，本次日志将储存在MainLog.txt中。
echo 按任意键开始...
pause>nul

cls
del Result.txt
del ips.txt
del ips1.txt
del ips2.txt
cls
echo 已开始...
echo.
echo Scan started. Port:%port%;Scan mode:%mode%...>MainLog.txt

for /f "eol= tokens=1-2 delims= " %%a in (ip.txt) do (
   title xyzzklk端口扫描工具V1.0-正在扫描:%%a %%b
   echo 对IP段 %%a %%b 的端口扫描已开始。
   echo The scanning of the range %%a %%b in %mode% scan mode has started.>>MainLog.txt
   %mode%scan.exe %mode% %%a %%b %port% 1000 /save
   title xyzzklk端口扫描工具V1.0-处理结果:%%a %%b
   echo 对IP段 %%a %%b 的端口扫描已结束，正在储存。
   echo The scanning of the range %%a %%b in %mode% scan mode has finished.Saving...>>MainLog.txt
   echo IPs saved.>>MainLog.txt
   for /f "eol=- tokens=1 delims= " %%i in (Result.txt) do echo %%i>>ips1.txt
   del Result.txt
   for /f "eol=P tokens=1 delims= " %%i in (ips1.txt) do echo %%i>>ips2.txt
   del ips1.txt
   for /f "eol=S tokens=1 delims= " %%i in (ips2.txt) do echo %%i>>ips.txt
   del ips2.txt
)

title xyzzklk端口扫描工具V1.0-扫描完成
echo 扫描完成，按任意键退出...
echo Scan finished...>>MainLog.txt
pause>nul
exit