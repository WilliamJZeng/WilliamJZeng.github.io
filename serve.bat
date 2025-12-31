@echo off
echo Starting Jekyll server...
echo.
echo The website will open in your browser once the server is ready.
echo Press Ctrl+C to stop the server when done.
echo.

REM Get the directory where this batch file is located
set SCRIPT_DIR=%~dp0

REM Start Jekyll server in a new window, changing to the correct directory first
start "Jekyll Server" cmd /k "cd /d "%SCRIPT_DIR%" && bundle exec jekyll serve -l -H localhost"

REM Wait for server to start (adjust timeout if needed)
timeout /t 5 /nobreak >nul

REM Open browser to localhost:4000
start http://localhost:4000

echo.
echo Server is running! Close the Jekyll Server window to stop.
