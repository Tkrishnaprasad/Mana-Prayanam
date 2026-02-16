# Complete Setup and Launch Script for Mana Prayanam
# Run this AFTER Node.js installation is complete and PowerShell is restarted

Write-Host "====================================" -ForegroundColor Green
Write-Host "Mana Prayanam - Complete Setup" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Write-Host ""

# Check Node.js
Write-Host "Step 1: Checking Node.js..." -ForegroundColor Cyan
try {
    $nodeVersion = & node --version 2>&1
    $npmVersion = & npm --version 2>&1
    if ($LASTEXITCODE -ne 0) { throw }
    Write-Host "✓ Node.js: $nodeVersion" -ForegroundColor Green
    Write-Host "✓ npm: $npmVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ ERROR: Node.js not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please:" -ForegroundColor Yellow
    Write-Host "1. Complete the Node.js installation" -ForegroundColor White
    Write-Host "2. Close this PowerShell window" -ForegroundColor White
    Write-Host "3. Open a NEW PowerShell window" -ForegroundColor White
    Write-Host "4. Run this script again" -ForegroundColor White
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "Step 2: Installing Backend Dependencies..." -ForegroundColor Cyan
Set-Location "$PSScriptRoot\backend"
Write-Host "Running: npm install (this may take a few minutes)" -ForegroundColor Gray
npm install --loglevel=error
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Backend installation failed!" -ForegroundColor Red
    Set-Location $PSScriptRoot
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host "✓ Backend dependencies installed" -ForegroundColor Green
Set-Location $PSScriptRoot

Write-Host ""
Write-Host "Step 3: Installing Frontend Dependencies..." -ForegroundColor Cyan
Set-Location "$PSScriptRoot\frontend"
Write-Host "Running: npm install (this may take a few minutes)" -ForegroundColor Gray
npm install --loglevel=error
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Frontend installation failed!" -ForegroundColor Red
    Set-Location $PSScriptRoot
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host "✓ Frontend dependencies installed" -ForegroundColor Green
Set-Location $PSScriptRoot

Write-Host ""
Write-Host "====================================" -ForegroundColor Green
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Write-Host ""

# Check MongoDB
Write-Host "Step 4: Checking MongoDB..." -ForegroundColor Cyan
$mongoRunning = Test-NetConnection -ComputerName localhost -Port 27017 -InformationLevel Quiet -WarningAction SilentlyContinue
if ($mongoRunning) {
    Write-Host "✓ MongoDB is running on localhost:27017" -ForegroundColor Green
} else {
    Write-Host "⚠ MongoDB not detected on localhost:27017" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Options to setup MongoDB:" -ForegroundColor White
    Write-Host "A) Install MongoDB locally: https://www.mongodb.com/try/download/community" -ForegroundColor Cyan
    Write-Host "B) Use MongoDB Atlas (Cloud): https://www.mongodb.com/cloud/atlas" -ForegroundColor Cyan
    Write-Host ""
    $continue = Read-Host "Do you want to continue anyway? (Y/N)"
    if ($continue -ne "Y" -and $continue -ne "y") {
        Write-Host "Setup complete. Configure MongoDB and run start-app.ps1 later." -ForegroundColor Yellow
        Read-Host "Press Enter to exit"
        exit 0
    }
}

Write-Host ""
Write-Host "Step 5: Starting Application..." -ForegroundColor Cyan
Write-Host ""

# Start Backend
Write-Host "Starting Backend Server (port 5000)..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Write-Host 'Mana Prayanam Backend Server' -ForegroundColor Green; cd '$PSScriptRoot\backend'; npm start"

# Wait for backend to initialize
Write-Host "Waiting 5 seconds for backend to start..." -ForegroundColor Gray
Start-Sleep -Seconds 5

# Start Frontend
Write-Host "Starting Frontend Server (port 3000)..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Write-Host 'Mana Prayanam Frontend Server' -ForegroundColor Green; cd '$PSScriptRoot\frontend'; npm start"

Write-Host ""
Write-Host "====================================" -ForegroundColor Green
Write-Host "🚀 Application Launching!" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Write-Host ""
Write-Host "Backend:  http://localhost:5000" -ForegroundColor Cyan
Write-Host "Frontend: http://localhost:3000" -ForegroundColor Cyan
Write-Host ""
Write-Host "The application will open in your browser automatically." -ForegroundColor White
Write-Host ""
Write-Host "Two server windows have been opened:" -ForegroundColor Yellow
Write-Host "- Backend Server (keep it running)" -ForegroundColor White
Write-Host "- Frontend Server (keep it running)" -ForegroundColor White
Write-Host ""
Write-Host "Press any key to close this window..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
