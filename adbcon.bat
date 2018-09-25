@echo off
set devid=%1
set port=%2

@echo on
adb -s %devid% tcpip %port%
adb emu kill
adb kill-server
adb start-server

for /f "usebackq tokens=*" %%i IN (`adb shell "ip addr show wlan0 | grep 192.168 | sed -e 's/^.*inet[^6][^0-9]*\([0-9.]*\)[^0-9]*.*$/\1/'"`) DO @set device_ip=%%i

adb connect %device_ip%:%port%

