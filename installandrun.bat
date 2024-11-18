@echo off
pip uninstall pycrypto -y
pip install discord.py
pip install pycryptodome
pip show pycryptodome

start decryptsaved.exe
exit