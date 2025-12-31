@echo off
echo Starting Jekyll server...
echo.
echo Waiting for server to be ready...
echo.

REM Get the directory where this batch file is located
set SCRIPT_DIR=%~dp0

REM Start Jekyll server in a new window, changing to the correct directory first
start "Jekyll Server" cmd /k "cd /d "%SCRIPT_DIR%" && bundle exec jekyll serve -l -H localhost"

REM Wait for server to be ready by polling it
set MAX_ATTEMPTS=60
set ATTEMPT=0

:wait_loop
set /a ATTEMPT+=1
if %ATTEMPT% gtr %MAX_ATTEMPTS% (
    echo Server did not start within 60 seconds. Please check the Jekyll Server window for errors.
    pause
    exit /b 1
)

REM Try to connect to localhost:4000 (suppress error output)
curl -s http://localhost:4000 >nul 2>&1
if %errorlevel% equ 0 (
    echo Server is ready!
    goto server_ready
)

REM Wait 1 second before trying again
timeout /t 1 /nobreak >nul
goto wait_loop

:server_ready
REM Open browser to localhost:4000
start http://localhost:4000

echo.
echo Browser opened. Close the Jekyll Server window when done.
echo.
