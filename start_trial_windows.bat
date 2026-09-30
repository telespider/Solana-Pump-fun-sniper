@echo off
REM start_trial.bat - Windows launcher for the pumpfun sniper trial binaries
setlocal

set "SCRIPT_DIR=%~dp0"
set "BIN=%SCRIPT_DIR%trial\pumpfun-sniper.exe"

if not exist "%BIN%" (
    echo error: binary not found: %BIN%
    exit /b 1
)

echo info: OS=Windows -> %BIN%
"%BIN%" %*