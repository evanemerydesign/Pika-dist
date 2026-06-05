@echo off
REM ============================================================================
REM  Pika installer — double-click to install the Pika plug-in into Rhino 8.
REM  Keep this .bat in the SAME FOLDER as the pika-*.yak file, then run it.
REM ============================================================================
setlocal

set "YAK=C:\Program Files\Rhino 8\System\Yak.exe"
if not exist "%YAK%" (
  echo.
  echo  ERROR: Could not find Rhino 8's Yak tool at:
  echo     %YAK%
  echo  Make sure Rhino 8 is installed, then run this again.
  echo.
  pause
  exit /b 1
)

REM Confirm a .yak is present next to this script.
if not exist "%~dp0pika-*.yak" (
  echo.
  echo  ERROR: No pika-*.yak found in this folder:
  echo     %~dp0
  echo  Put this .bat next to the pika-...-win.yak file and run it again.
  echo.
  pause
  exit /b 1
)

echo.
echo  Installing Pika into Rhino 8...
echo.
"%YAK%" install --source "%~dp0" pika
if errorlevel 1 (
  echo.
  echo  Install failed. If Rhino is open, close it and try again.
  pause
  exit /b 1
)

echo.
echo  ============================================================
echo   Pika installed.  Now:
echo     1. Restart Rhino 8 (close and reopen it).
echo     2. Type:   Pika      (or Panels menu -^> Pika)
echo  ============================================================
echo.
pause
