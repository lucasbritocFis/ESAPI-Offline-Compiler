@echo off
setlocal enabledelayedexpansion

echo ================================================================
echo   ESAPI Environment Checker
echo   (Window will stay open for 20 seconds or until you press a key)
echo ================================================================
echo.

REM --- 1. Check C# compiler ------------------------------------------------
set "CSC_PATH=C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe"
if exist "%CSC_PATH%" (
    echo [OK] Compiler found: %CSC_PATH%
) else (
    echo [ERROR] csc.exe not found!
    echo Please verify that .NET Framework 4.x (64-bit) is installed.
    echo.
)

REM --- 2. Search for ESAPI (common Varian RTM paths) -----------------------
set "ESAPI_FOUND="
echo.
echo Searching for ESAPI in common locations (Varian RTM)...
echo.

for %%P in ("C:\Program Files (x86)\Varian\RTM" "C:\Varian\RTM" "C:\Program Files\Varian\RTM") do (
    if exist "%%~P" (
        for /d %%D in ("%%~P\*") do (
            if exist "%%D\esapi\API\VMS.TPS.Common.Model.API.dll" (
                set "ESAPI_FOUND=%%D\esapi\API"
                echo [FOUND] ESAPI at: !ESAPI_FOUND!
                goto :found
            )
        )
    )
)

:found
if defined ESAPI_FOUND (
    echo.
    echo ================================================================
    echo   LINE TO COPY INTO YOUR build.bat:
    echo ================================================================
    echo.
    echo   set "ESAPI_DIR=!ESAPI_FOUND!"
    echo.
) else (
    echo.
    echo [WARNING] VMS.TPS.Common.Model.API.dll not found.
    echo You will need to edit the path manually in build.bat.
    echo.
)

echo ================================================================
echo   Check complete. The window will close automatically in 20s.
echo   (Or press any key now to close.)
echo ================================================================

timeout /t 20 /nobreak >nul
pause
