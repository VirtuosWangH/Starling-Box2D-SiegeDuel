@echo off

setlocal

choice /c:dep

if ERRORLEVEL 1 set extension=d
if ERRORLEVEL 2 set extension=e
if ERRORLEVEL 3 set extension=p


for /F %%x in ('dir /B /D *.png') do (
    png2atf -c %extension% -r -i %%x -o "%%~dx%%~px%%~nx_"%extension%.atf
)

endlocal

pause