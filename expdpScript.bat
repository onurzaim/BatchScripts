REM General purpose Oracle Backup script for windows systems

REM Set date variables with dates
setlocal
For /f "tokens=1-3 delims=. " %%a in ('date /t') do (set mydate=%%c-%%b)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a%%b)

REM Backup schemas you want

expdp UYUMSOFT/uyumsoft@UYUM schemas=(UYUMSOFT) directory=DATA_PUMP_DIR dumpfile=UYUMDB_%mydate%_%mytime%.dmp 
expdp UYUMSOFT/uyumsoft@UYUM schemas=(UYUMLOG) directory=DATA_PUMP_DIR dumpfile=UYUMLOG_%mydate%_%mytime%.dmp CONTENT=METADATA_ONLY 

REM Compress files (Winrar was chosen here) 
"C:\Program Files\WinRAR\rar.exe" a -r "C:\OracleBackup\expdp\UYUMDB_%mydate%_%mytime%.rar" C:\OracleBackup\expdp\UYUMDB_%mydate%_%mytime%.dmp C:\OracleBackup\expdp\UYUMLOG_%mydate%_%mytime%.dmp 

REM
mkdir C:\OracleBackup\%mydate%_%mytime%
move C:\OracleBackup\expdp\UYUMDB_%mydate%_%mytime%.rar C:\OracleBackup\%mydate%_%mytime%

REM copy to an *nix system with pscp (download required)
pscp -pw password C:\OracleBackup\%mydate%_%mytime%\UYUMDB_%mydate%_%mytime%.rar user@server.com:/home/user
