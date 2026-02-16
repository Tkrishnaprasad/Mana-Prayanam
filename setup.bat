@echo off
echo ====================================
echo Mana Prayanam - Setup Script
echo ====================================
echo.

echo Checking Node.js installation...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Node.js is not installed or not in PATH
    echo Please install Node.js and restart your terminal
    echo Download from: https://nodejs.org
    pause
    exit /b 1
)

echo Node.js found!
node --version
npm --version
echo.

echo ====================================
echo Installing Backend Dependencies...
echo ====================================
cd backend
call npm install
if %errorlevel% neq 0 (
    echo ERROR: Backend installation failed
    pause
    exit /b 1
)
cd ..
echo Backend dependencies installed successfully!
echo.

echo ====================================
echo Installing Frontend Dependencies...
echo ====================================
cd frontend
call npm install
if %errorlevel% neq 0 (
    echo ERROR: Frontend installation failed
    pause
    exit /b 1
)
cd ..
echo Frontend dependencies installed successfully!
echo.

echo ====================================
echo Setup Complete!
echo ====================================
echo.
echo Next steps:
echo 1. Make sure MongoDB is running (localhost:27017)
echo    - Install from: https://www.mongodb.com/try/download/community
echo    - Or use MongoDB Atlas: https://www.mongodb.com/cloud/atlas
echo.
echo 2. Update backend\.env file if needed
echo.
echo 3. Run start-app.bat to launch the application
echo.
pause
