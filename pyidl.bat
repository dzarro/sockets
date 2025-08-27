
rem Windows bat file to start Python with IDL bridge
rem Zarro (ADNET) 11-25-22

set IDL_DIR=C:\Program Files\Harris\IDL88
set SSW=C:\SSW
set PYTHONPATH=%IDL_DIR%\bin\bin.x86_64;%IDL_DIR%\lib\bridges
set SSW_INSTR=ontology
rem set IDL_STARTUP=C:\IDL\pidl_startup.pro
set PYTHONSTARTUP=C:\IDL\python_startup.py

python -B


