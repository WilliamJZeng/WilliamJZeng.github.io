@echo off
echo Starting Jekyll server...
echo.
echo The website will open in your browser once the server is ready.
echo Press Ctrl+C to stop the server when done.
echo.

REM Start Jekyll server in a new window
start "Jekyll Server" cmd /k "bundle exec jekyll serve -l -H localhost"

REM Wait for server to start (adjust timeout if needed)
timeout /t 5 /nobreak >nul

REM Open browser to localhost:4000
start http://localhost:4000

echo.
echo Server is running! Close the Jekyll Server window to stop.
