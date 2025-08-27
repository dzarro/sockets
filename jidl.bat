
rem Windows bat file to start IDL with Python bridge
rem Zarro (ADNET) 8-22-20

set IDL_DIR=C:\Program Files\Harris\IDL88

set SSW_INSTR=ontology

set SSW=C:\SSW

set PYTHONPATH=%IDL_DIR%\bin\bin.x86_64;%IDL_DIR%\lib\bridges

set IDL_STARTUP=%SSW%\gen\idl\ssw_system\idl_startup_windows.pro

set SSW_PERSONAL_STARTUP=C:\IDL\pidl_startup.pro

rem set PYTHONSTARTUP=C:\IDL\python_startup.py

cd %CD%

set JUPYTER_PATH=%IDL_DIR%\lib\bridges

jupyter notebook

