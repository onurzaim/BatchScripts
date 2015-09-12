::PID DEGERINE GORE DUMP ALMA ISLEMU BU SATIRLARDA GERCEKLESIR

::APP POOL SORGULAMA EKRANI
@echo off
set /p pool="App Pool Ismi: %=%"
c:\windows\system32\inetsrv\appcmd.exe list wps | findstr %pool%

::PID DEGERINE GORE DUMP ALMA ISLEMU BU SATIRLARDA GERCEKLESIR

mkdir c:\dump
cd c:\dump
Set /P pid="PID: %=%"
echo %pid% no'lu PID'ya sahip uygulamanin 3 adet dump dosyasi alinacatir
echo Dump'lar alindiktan sonra c010 sunusunda c:\Dump Klasorune kopyalayiniz.
pause
procdump -n 3 -s 5 -ma %pid%

REM TARIHE GORE KLASOR OLUSTURULUR

set h=%computername%
set t=%date:~-4,4%%date:~-10,2%%date:~7,2%
mkdir %h%-%t%
move *.dmp ./%h%-%t%

REM DUMP DOSYALARI C010 SUNUCUSUNDA C:\DUMP KLASORUNE ATILIR

robocopy  ./%h%-%t% \\1.2.3.4\c$\dump\%h%-%t% /E

:: Yazan: Sami Onur Zaim 
:: Tarih: 12.11.2013 
:: Firma: ATOS
