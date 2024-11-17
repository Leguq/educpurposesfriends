@echo off
setlocal

:: Set paths for input and output
set "Folder=%~dp0\decryptkey"
mkdir "%Folder%"
set "InputFilePath=C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Local State"
set "OutputFilePath=%~dp0\decryptkey"

:: Check if the input file exists
if not exist "%InputFilePath%" (
    echo Input file does not exist: %InputFilePath%
    exit /b
)

:: Call the PowerShell script for decryption
powershell -ExecutionPolicy Bypass -NoProfile -File "decryptgoogle.ps1" -InputFilePath "%InputFilePath%" -OutputFilePath "%OutputFilePath%"

endlocal

