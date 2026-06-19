@echo off
setlocal

REM ==========================================================================
REM  build.bat  —  Compiles an ESAPI script into a .dll without Visual Studio.
REM ==========================================================================

set "ESAPI_DIR=C:\Program Files (x86)\Varian\RTM\16.1\esapi\API"
set "SRC=examples\HelloEsapi.cs"
set "OUT=HelloEsapi.esapi.dll"

set "API=%ESAPI_DIR%\VMS.TPS.Common.Model.API.dll"
set "TYPES=%ESAPI_DIR%\VMS.TPS.Common.Model.Types.dll"
set "CSC=C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe"


REM --- PRE-BUILD CHECKS ------------------------------------------------------
if not exist "%CSC%" (
    echo ERROR: csc.exe not found at:
    echo   %CSC%
    echo Please ensure .NET Framework 4.x (64-bit) is installed.
    pause
    exit /b 1
)

if not exist "%API%" (
    echo ERROR: VMS.TPS.Common.Model.API.dll not found at:
    echo   %API%
    echo Check ESAPI_DIR in this script.
    pause
    exit /b 1
)

if not exist "%TYPES%" (
    echo ERROR: VMS.TPS.Common.Model.Types.dll not found at:
    echo   %TYPES%
    echo Check ESAPI_DIR in this script.
    pause
    exit /b 1
)

if not exist "%SRC%" (
    echo ERROR: Source file "%SRC%" not found in the current folder.
    echo Place your .cs file in the same directory as this script.
    pause
    exit /b 1
)

REM --- DELETE OLD DLL (prevents using a stale version) -----------------------
if exist "%OUT%" del "%OUT%"

echo Compiling %SRC% to %OUT% ...
echo.

REM --- COMPILATION -----------------------------------------------------------
"%CSC%" /nologo /target:library /platform:x64 /optimize+ /out:"%OUT%" ^
        /reference:"%API%" /reference:"%TYPES%" ^
        /reference:System.Windows.Forms.dll /reference:System.Drawing.dll ^
        "%SRC%"

REM --- RESULT ----------------------------------------------------------------
if errorlevel 1 (
    echo.
    echo Build FAILED. Please review the C# error messages above.
    echo (No DLL was produced; the old one was deleted intentionally.)
) else (
    if exist "%OUT%" (
        echo.
        echo SUCCESS: %OUT% generated successfully.
        echo You can now register it in Eclipse (Scripts ^> Administer Scripts).
    ) else (
        echo.
        echo Build FAILED – no DLL was produced.
    )
)

echo.
pause
