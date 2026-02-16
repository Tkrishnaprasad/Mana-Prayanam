@echo off
echo ====================================
echo Mana Prayanam - Starting Application
echo ====================================
echo.

echo Checking Node.js...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Node.js is not installed
    echo Please run setup.bat first
    pause
    exit /b 1
)

echo Starting Backend Server on port 5000...
start "Mana Prayanam Backend" cmd /k "cd backend && npm start"

echo Waiting 5 seconds for backend to initialize...
timeout /t 5 /nobreak >nul

echo Starting Frontend Server on port 3000...
start "Mana Prayanam Frontend" cmd /k "cd frontend && npm start"

echo.
echo ====================================
echo Application Starting!
echo ====================================
echo.
echo Backend:  http://localhost:5000
echo Frontend: http://localhost:3000
echo.
echo The browser will open automatically in a few seconds...
echo.
echo Press any key to close this window
echo (Backend and Frontend will continue running in separate windows)
pause >nul
