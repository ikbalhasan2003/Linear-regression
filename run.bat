
@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul 2>&1
cd /d "%~dp0"
title Linear Regression - Easy Runner

set "NB=notebooks\Experiment2-regression.ipynb"
set "MIRROR=https://pypi.tuna.tsinghua.edu.cn/simple"

echo =============================================================
echo   Linear Regression Experiment - easy runner
echo =============================================================
echo.
echo   What do you want to do?
echo     [1] Run everything (default) : execute the notebook,
echo         regenerate all figures/tables, then open 2 windows
echo         (browser = HTML report, Explorer = outputs folder)
echo     [2] Open Jupyter Notebook in the browser
echo     [3] Open the outputs folder (figures + result tables)
echo     [4] Reinstall / repair dependencies
echo     [5] Run everything but open no window at all
echo.
set "ANSWER=1"
set /p ANSWER="Press Enter for [1], or type 2 / 3 / 4 / 5: "
echo.

REM ------------------------------------------------------------
REM Environment: reuse .venv, create it if missing
REM ------------------------------------------------------------
if exist ".venv\Scripts\python.exe" (
    set "PY=%CD%\.venv\Scripts\python.exe"
    echo [env] Using the existing virtual environment: .venv
) else (
    set "SYS_PY="
    where python >nul 2>&1
    if !errorlevel!==0 set "SYS_PY=python"
    if not defined SYS_PY (
        where py >nul 2>&1
        if !errorlevel!==0 set "SYS_PY=py -3"
    )
    if not defined SYS_PY (
        echo [env] ERROR: Python was not found.
        echo       Install Python 3.11+ from https://www.python.org/downloads/
        echo       and tick "Add python.exe to PATH" during setup.
        echo.
        pause
        exit /b 1
    )
    echo [env] No .venv found - creating one, first run only, about 1 min...
    !SYS_PY! -m venv .venv
    if errorlevel 1 (
        echo [env] ERROR: could not create the virtual environment.
        pause
        exit /b 1
    )
    set "PY=%CD%\.venv\Scripts\python.exe"
)

REM ------------------------------------------------------------
REM Dependencies: install only when something is missing
REM ------------------------------------------------------------
"%PY%" -c "import numpy, pandas, matplotlib, sklearn, nbconvert" >nul 2>&1
if errorlevel 1 goto :install
if "%ANSWER%"=="4" goto :install
goto :dispatch

:install
echo [env] Installing dependencies from requirements.txt...
"%PY%" -m pip install -r requirements.txt || "%PY%" -m pip install -i %MIRROR% -r requirements.txt
if errorlevel 1 (
    echo [env] ERROR: installation failed. Check your internet connection.
    pause
    exit /b 1
)
echo [env] Dependencies OK.
echo.
if "%ANSWER%"=="4" (
    pause
    exit /b 0
)

:dispatch
if "%ANSWER%"=="2" goto :jupyter
if "%ANSWER%"=="3" goto :openoutputs
goto :runall

REM ------------------------------------------------------------
REM [1] Run everything
REM ------------------------------------------------------------
:runall
if not exist "%NB%" (
    echo [run] ERROR: notebook not found: %NB%
    pause
    exit /b 1
)
echo [run] Executing the notebook (same as Kernel ^> Restart ^& Run All)...
echo [run] This takes about 1 minute. Please wait - do NOT close this window.
"%PY%" -m jupyter nbconvert --to notebook --execute --inplace "%NB%"
if errorlevel 1 (
    echo.
    echo [run] ERROR: the notebook stopped on an error, shown above.
    pause
    exit /b 1
)
echo [run] Done. Exporting a read-only HTML copy to outputs\ ...
"%PY%" -m jupyter nbconvert --to html --output-dir outputs "%NB%" >nul 2>&1
echo.
echo [run] Generated files:
"%PY%" -c "import pathlib; [print('    ', p.as_posix()) for d in ('outputs/figures','outputs/results') for p in sorted(pathlib.Path(d).glob('*'))]" 2>nul
echo     outputs/Experiment2-regression.html   (full report: code + plots + tables)
echo.
if "%ANSWER%"=="5" (
    echo [run] Option 5 selected - no window opened.
    echo       Report : %CD%\outputs\Experiment2-regression.html
    echo       Files  : %CD%\outputs
    echo.
    pause
    exit /b 0
)
echo [run] Opening the HTML report in your browser...
start "" "%CD%\outputs\Experiment2-regression.html"
echo [run] Opening the outputs folder...
start "" "%CD%\outputs"
echo.
echo -------------------------------------------------------------
echo  Everything is regenerated. For the lab report, read:
echo     reports\README.md   (which figure goes in which section)
echo -------------------------------------------------------------
echo.
pause
exit /b 0

REM ------------------------------------------------------------
REM [2] Jupyter
REM ------------------------------------------------------------
:jupyter
echo [jupyter] Starting Jupyter - it opens in your browser automatically.
echo           To stop it: press Ctrl+C in this window, or close the window.
echo.
"%PY%" -m jupyter notebook "%NB%"
pause
exit /b 0

REM ------------------------------------------------------------
REM [3] Open outputs
REM ------------------------------------------------------------
:openoutputs
if not exist "outputs" mkdir "outputs"
start "" "%CD%\outputs"
exit /b 0
