@echo off
title Setting DNS For Windows XP Or 10

:OS_Selection
cls
echo Select Operating System
echo.
echo 0. Windows XP
echo 1. Windows 10
echo.
set /p Selected_OS="Operating System: "

if %Selected_OS%==0 GOTO Windows_XP
if %Selected_OS%==1 GOTO Windows_Ten
if %Selected_OS% GTR 1 GOTO Error_For_OS

:Error_For_OS
cls
echo Error, invalid OS selection
pause
GOTO OS_Selection

REM WINDOWS XP DNS SETTING STARTS
:Windows_XP
title Setting DNS For Windows XP
color 2A

:Interfaces_On_XP
cls
echo Type Interface Name
netsh interface show interface
set /p Select_Interface_For_XP="Interface Name: "
echo.

:IPv_For_XP
cls
echo Select Internet Protocol Version
echo.
echo 0. IPv4
echo 1. IPv6
echo 2. Set For Both IPv4 And IPv6
echo 3. Reset Both IPv4 And IPv6
echo 4. Main Menu
echo.
set /p Select_Version_For_XP="Internet Protocol Version: "

if %Select_Version_For_XP%==0 GOTO IPv4_For_XP
if %Select_Version_For_XP%==1 GOTO IPv6_For_XP
if %Select_Version_For_XP%==2 GOTO Set_Both_On_XP
if %Select_Version_For_XP%==3 GOTO Reset_Both_On_XP
if %Select_Version_For_XP%==4 GOTO Interfaces_On_XP
if %Select_Version_For_XP% GTR 4 GOTO Error_For_XP

:IPv4_For_XP
cls
echo Select IPv4 DNS Service Provider
echo.
echo 0. Google DNS IPv4
echo      8.8.8.8
echo      8.8.4.4
echo 1. Cloudflare and APNIC DNS IPv4
echo      1.1.1.1
echo      1.0.0.1
echo 2. Open DNS IPv4 (Kids Friendly)
echo      208.67.222.123
echo      208.67.220.123
echo 3. Main Menu
echo.
set /p IPv4_Provider_For_XP="IPv4 DNS Service Provider: "
echo.

if %Select_Version_For_XP%==0 if %IPv4_Provider_For_XP%==0 GOTO IPv4_Google_DNS_For_XP
if %Select_Version_For_XP%==0 if %IPv4_Provider_For_XP%==1 GOTO IPv4_Cloudflare_and_APNIC_DNS_For_XP
if %Select_Version_For_XP%==0 if %IPv4_Provider_For_XP%==2 GOTO IPv4_Open_DNS_For_XP
if %IPv4_Provider_For_XP%==3 GOTO Interfaces_On_XP
if %IPv4_Provider_For_XP% GTR 3 GOTO Error_For_XP

:IPv6_For_XP
cls
echo Select IPv6 DNS Service Provider
echo.
echo 0. Google DNS IPv6
echo      2001:4860:4860::8888
echo      2001:4860:4860::8844
echo 1. Cloudflare and APNIC DNS IPv6
echo      2606:4700:4700::1111
echo      2606:4700:4700::1001
echo 2. Main Menu
echo.
set /p IPv6_Provider_For_XP="IPv6 DNS Service Provider: "
echo.

if %Select_Version_For_XP%==1 if %IPv6_Provider_For_XP%==0 GOTO IPv6_Google_DNS_For_XP
if %Select_Version_For_XP%==1 if %IPv6_Provider_For_XP%==1 GOTO IPv6_Cloudflare_and_APNIC_DNS_For_XP
if %IPv6_Provider_For_XP%==2 GOTO Interfaces_On_XP
if %IPv6_Provider_For_XP% GTR 2 GOTO Error_For_XP

:Set_Both_On_XP
cls
echo Select IPv4 and IPv6 DNS Service Provider
echo.
echo 0. Google DNS IPv4 and IPv6
echo     IPv4
echo       8.8.8.8
echo       8.8.4.4
echo     IPv6
echo      2001:4860:4860::8888
echo      2001:4860:4860::8844
echo 1. Cloudflare and APNIC DNS IPv4 and IPv6
echo     IPv4
echo       1.1.1.1
echo       1.0.0.1
echo     IPv6
echo       2606:4700:4700::1111
echo       2606:4700:4700::1001
echo 2. Main Menu
echo.
set /p IPv4_and_IPv6_Provider_For_XP="IPv4 And IPv6 DNS Service Provider: "
echo.

if %Select_Version_For_XP%==2 if %IPv4_and_IPv6_Provider_For_XP%==0 GOTO IPv4_and_IPv6_Google_DNS_For_XP
if %Select_Version_For_XP%==2 if %IPv4_and_IPv6_Provider_For_XP%==1 GOTO IPv4_and_IPv6_Cloudflare_and_APNIC_DNS_For_XP
if %IPv4_and_IPv6_Provider_For_XP%==2 GOTO Interfaces_On_XP
if %IPv4_and_IPv6_Provider_For_XP% GTR 2 GOTO Error_For_XP

:Error_For_XP
cls
echo Error, invalid input
pause
GOTO Interfaces_On_XP

:IPv4_Google_DNS_For_XP
cls
netsh interface ip delete dns name="%Select_Interface_For_XP%" addr=all
netsh interface ip add dns name="%Select_Interface_For_XP%" addr=8.8.8.8 index=1
netsh interface ip add dns name="%Select_Interface_For_XP%" addr=8.8.4.4 index=2
ipconfig /flushdns
pause
GOTO Interfaces_On_XP

:IPv4_Cloudflare_and_APNIC_DNS_For_XP
cls
netsh interface ip delete dns name="%Select_Interface_For_XP%" addr=all
netsh interface ip add dns name="%Select_Interface_For_XP%" addr=1.1.1.1 index=1
netsh interface ip add dns name="%Select_Interface_For_XP%" addr=1.0.0.1 index=2
ipconfig /flushdns
pause
GOTO Interfaces_On_XP

:IPv4_Open_DNS_For_XP
cls
netsh interface ip delete dns name="%Select_Interface_For_XP%" addr=all
netsh interface ip add dns name="%Select_Interface_For_XP%" addr=208.67.222.123 index=1
netsh interface ip add dns name="%Select_Interface_For_XP%" addr=208.67.220.123 index=2
ipconfig /flushdns
pause
GOTO Interfaces_On_XP

:IPv6_Google_DNS_For_XP
cls
netsh interface ipv6 install
netsh interface ipv6 delete dns interface="%Select_Interface_For_XP%" address=all
netsh interface ipv6 add dns interface="%Select_Interface_For_XP%" address=2001:4860:4860::8888 index=1
netsh interface ipv6 add dns interface="%Select_Interface_For_XP%" address=2001:4860:4860::8844 index=2
ipconfig /flushdns
pause
GOTO Interfaces_On_XP

:IPv6_Cloudflare_and_APNIC_DNS_For_XP
cls
netsh interface ipv6 install
netsh interface ipv6 delete dns interface="%Select_Interface_For_XP%" address=all
netsh interface ipv6 add dns interface="%Select_Interface_For_XP%" address=2606:4700:4700::1111 index=1
netsh interface ipv6 add dns interface="%Select_Interface_For_XP%" address=2606:4700:4700::1001 index=2
ipconfig /flushdns
pause
GOTO Interfaces_On_XP

:IPv4_and_IPv6_Google_DNS_For_XP
cls
netsh interface ip delete dns name="%Select_Interface_For_XP%" addr=all
netsh interface ip add dns name="%Select_Interface_For_XP%" addr=8.8.8.8 index=1
netsh interface ip add dns name="%Select_Interface_For_XP%" addr=8.8.4.4 index=2
netsh interface ipv6 install
netsh interface ipv6 delete dns interface="%Select_Interface_For_XP%" address=all
netsh interface ipv6 add dns interface="%Select_Interface_For_XP%" address=2001:4860:4860::8888 index=1
netsh interface ipv6 add dns interface="%Select_Interface_For_XP%" address=2001:4860:4860::8844 index=2
ipconfig /flushdns
pause
GOTO Interfaces_On_XP

:IPv4_and_IPv6_Cloudflare_and_APNIC_DNS_For_XP
cls
netsh interface ip delete dns name="%Select_Interface_For_XP%" addr=all
netsh interface ip add dns name="%Select_Interface_For_XP%" addr=1.1.1.1 index=1
netsh interface ip add dns name="%Select_Interface_For_XP%" addr=1.0.0.1 index=2
netsh interface ipv6 install
netsh interface ipv6 delete dns interface="%Select_Interface_For_XP%" address=all
netsh interface ipv6 add dns interface="%Select_Interface_For_XP%" address=2606:4700:4700::1111 index=1
netsh interface ipv6 add dns interface="%Select_Interface_For_XP%" address=2606:4700:4700::1001 index=2
ipconfig /flushdns
pause
GOTO Interfaces_On_XP

:Reset_Both_On_XP
cls
netsh interface ip delete dns name="%Select_Interface_For_XP%" addr=all
netsh interface ipv6 delete dns interface="%Select_Interface_For_XP%" address=all
ipconfig /flushdns
pause
GOTO Interfaces_On_XP
REM WINDOWS XP DNS SETTING ENDS


REM WINDOWS 10 DNS SETTING STARTS
:Windows_Ten
title Setting DNS For Windows 10
color 3B

:Interfaces_On_Ten
cls
echo Select Interface Idx
netsh interface ipv4 show interfaces
netsh interface ipv6 show interfaces
set /p Select_Interface_For_Ten="Interface Idx: "
echo.

:IPv_For_Ten
cls
echo Select Internet Protocol Version
echo.
echo 0. IPv4
echo 1. IPv6
echo 2. Set For Both IPv4 And IPv6
echo 3. Reset Both IPv4 And IPv6
echo 4. Main Menu
echo.
set /p Select_Version_For_Ten="Internet Protocol Version: "

if %Select_Version_For_Ten%==0 GOTO IPv4_For_Ten
if %Select_Version_For_Ten%==1 GOTO IPv6_For_Ten
if %Select_Version_For_Ten%==2 GOTO Set_Both_On_Ten
if %Select_Version_For_Ten%==3 GOTO Reset_Both_On_Ten
if %Select_Version_For_Ten%==4 GOTO Interfaces_On_Ten
if %Select_Version_For_Ten% GTR 4 GOTO Error_For_Ten

:IPv4_For_Ten
cls
echo Select IPv4 DNS Service Provider
echo.
echo 0. Google DNS IPv4
echo      8.8.8.8
echo      8.8.4.4
echo 1. Cloudflare and APNIC DNS IPv4
echo      1.1.1.1
echo      1.0.0.1
echo 2. Open DNS IPv4 (Kids Friendly)
echo      208.67.222.123
echo      208.67.220.123
echo 3. Main Menu
echo.
set /p IPv4_Provider_For_Ten="IPv4 DNS Service Provider: "
echo.

if %Select_Version_For_Ten%==0 if %IPv4_Provider_For_Ten%==0 GOTO IPv4_Google_DNS_For_Ten
if %Select_Version_For_Ten%==0 if %IPv4_Provider_For_Ten%==1 GOTO IPv4_Cloudflare_and_APNIC_DNS_For_Ten
if %Select_Version_For_Ten%==0 if %IPv4_Provider_For_Ten%==2 GOTO IPv4_Open_DNS_For_Ten
if %IPv4_Provider_For_Ten%==3 GOTO Interfaces_On_Ten
if %IPv4_Provider_For_Ten% GTR 3 GOTO Error_For_Ten

:IPv6_For_Ten
cls
echo Select IPv6 DNS Service Provider
echo.
echo 0. Google DNS IPv6
echo      2001:4860:4860::8888
echo      2001:4860:4860::8844
echo 1. Cloudflare and APNIC DNS IPv6
echo      2606:4700:4700::1111
echo      2606:4700:4700::1001
echo 2. Main Menu
echo.
set /p IPv6_Provider_For_Ten="IPv6 DNS Service Provider: "
echo.

if %Select_Version_For_Ten%==1 if %IPv6_Provider_For_Ten%==0 GOTO IPv6_Google_DNS_For_Ten
if %Select_Version_For_Ten%==1 if %IPv6_Provider_For_Ten%==1 GOTO IPv6_Cloudflare_and_APNIC_DNS_For_Ten
if %IPv6_Provider_For_Ten%==2 GOTO Interfaces_On_Ten
if %IPv6_Provider_For_Ten% GTR 2 GOTO Error_For_Ten

:Set_Both_On_Ten
cls
echo Select IPv4 and IPv6 DNS Service Provider
echo.
echo 0. Google DNS IPv4 and IPv6
echo     IPv4
echo       8.8.8.8
echo       8.8.4.4
echo     IPv6
echo      2001:4860:4860::8888
echo      2001:4860:4860::8844
echo 1. Cloudflare and APNIC DNS IPv4 and IPv6
echo     IPv4
echo       1.1.1.1
echo       1.0.0.1
echo     IPv6
echo       2606:4700:4700::1111
echo       2606:4700:4700::1001
echo 2. Main Menu
echo.
set /p IPv4_and_IPv6_Provider_For_Ten="IPv4 And IPv6 DNS Service Provider: "
echo.

if %Select_Version_For_Ten%==2 if %IPv4_and_IPv6_Provider_For_Ten%==0 GOTO IPv4_and_IPv6_Google_DNS_For_Ten
if %Select_Version_For_Ten%==2 if %IPv4_and_IPv6_Provider_For_Ten%==1 GOTO IPv4_and_IPv6_Cloudflare_and_APNIC_DNS_For_Ten
if %IPv4_and_IPv6_Provider_For_Ten%==2 GOTO Interfaces_On_Ten
if %IPv4_and_IPv6_Provider_For_Ten% GTR 2 GOTO Error_For_Ten

:Error_For_Ten
cls
echo Error, invalid input
pause
GOTO Interfaces_On_Ten

:IPv4_Google_DNS_For_Ten
cls
netsh interface ipv4 delete dnsservers name="%Select_Interface_For_Ten%" all no
netsh interface ipv4 add dnsservers name="%Select_Interface_For_Ten%" 8.8.8.8 index=1 no
netsh interface ipv4 add dnsservers name="%Select_Interface_For_Ten%" 8.8.4.4 index=2 no
ipconfig /flushdns
pause
GOTO Interfaces_On_Ten

:IPv4_Cloudflare_and_APNIC_DNS_For_Ten
cls
netsh interface ipv4 delete dnsservers name="%Select_Interface_For_Ten%" all no
netsh interface ipv4 add dnsservers name="%Select_Interface_For_Ten%" 1.1.1.1 index=1 no
netsh interface ipv4 add dnsservers name="%Select_Interface_For_Ten%" 1.0.0.1 index=2 no
ipconfig /flushdns
pause
GOTO Interfaces_On_Ten

:IPv4_Open_DNS_For_Ten
cls
netsh interface ipv4 delete dnsservers name="%Select_Interface_For_Ten%" all no
netsh interface ipv4 add dnsservers name="%Select_Interface_For_Ten%" 208.67.222.123 index=1 no
netsh interface ipv4 add dnsservers name="%Select_Interface_For_Ten%" 208.67.220.123 index=2 no
ipconfig /flushdns
pause
GOTO Interfaces_On_Ten

:IPv6_Google_DNS_For_Ten
cls
netsh interface ipv6 delete dnsservers name="%Select_Interface_For_Ten%" all no
netsh interface ipv6 add dnsservers name="%Select_Interface_For_Ten%" 2001:4860:4860::8888 index=1 no
netsh interface ipv6 add dnsservers name="%Select_Interface_For_Ten%" 2001:4860:4860::8844 index=2 no
ipconfig /flushdns
pause
GOTO Interfaces_On_Ten

:IPv6_Cloudflare_and_APNIC_DNS_For_Ten
cls
netsh interface ipv6 delete dnsservers name="%Select_Interface_For_Ten%" all no
netsh interface ipv6 add dnsservers name="%Select_Interface_For_Ten%" 2606:4700:4700::1111 index=1 no
netsh interface ipv6 add dnsservers name="%Select_Interface_For_Ten%" 2606:4700:4700::1001 index=2 no
ipconfig /flushdns
pause
GOTO Interfaces_On_Ten

:IPv4_and_IPv6_Google_DNS_For_Ten
cls
netsh interface ipv4 delete dnsservers name="%Select_Interface_For_Ten%" all no
netsh interface ipv4 add dnsservers name="%Select_Interface_For_Ten%"  8.8.8.8 index=1 no
netsh interface ipv4 add dnsservers name="%Select_Interface_For_Ten%" 8.8.4.4 index=2 no
netsh interface ipv6 delete dnsservers name="%Select_Interface_For_Ten%" all no
netsh interface ipv6 add dnsservers name="%Select_Interface_For_Ten%" 2001:4860:4860::8888 index=1 no
netsh interface ipv6 add dnsservers name="%Select_Interface_For_Ten%" 2001:4860:4860::8844 index=2 no
ipconfig /flushdns
pause
GOTO Interfaces_On_Ten

:IPv4_and_IPv6_Cloudflare_and_APNIC_DNS_For_Ten
cls
netsh interface ipv4 delete dnsservers name="%Select_Interface_For_Ten%" all no
netsh interface ipv4 add dnsservers name="%Select_Interface_For_Ten%" 1.1.1.1 index=1 no
netsh interface ipv4 add dnsservers name="%Select_Interface_For_Ten%" 1.0.0.1 index=2 no
netsh interface ipv6 delete dnsservers name="%Select_Interface_For_Ten%" all no
netsh interface ipv6 add dnsservers name="%Select_Interface_For_Ten%" 2606:4700:4700::1111 index=1 no
netsh interface ipv6 add dnsservers name="%Select_Interface_For_Ten%" 2606:4700:4700::1001 index=2 no
ipconfig /flushdns
pause
GOTO Interfaces_On_Ten

:Reset_Both_On_Ten
cls
netsh interface ipv4 delete dnsservers name="%Select_Interface_For_Ten%" all no
netsh interface ipv6 delete dnsservers name="%Select_Interface_For_Ten%" all no
ipconfig /flushdns
pause
GOTO Interfaces_On_Ten
REM WINDOWS 10 DNS SETTING ENDS
