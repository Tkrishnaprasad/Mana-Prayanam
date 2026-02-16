# Mana Prayanam - Setup Script
# PowerShell version

Write-Host "====================================" -ForegroundColor Green
Write-Host "Mana Prayanam - Setup Script" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Write-Host ""

Write-Host "Checking Node.js installation..." -ForegroundColor Yellow
try {
    $nodeVersion = node --version 2>$null
    $npmVersion = npm --version 2>$null
    Write-Host "Node.js found: $nodeVersion" -ForegroundColor Green
    Write-Host "npm found: $npmVersion" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Node.js is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install Node.js and restart your terminal" -ForegroundColor Red
    Write-Host "Download from: https://nodejs.org" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "====================================" -ForegroundColor Green
Write-Host "Installing Backend Dependencies..." -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Set-Location backend
npm install
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Backend installation failed" -ForegroundColor Red
    Set-Location ..
    Read-Host "Press Enter to exit"
    exit 1
}
Set-Location ..
Write-Host "Backend dependencies installed successfully!" -ForegroundColor Green
Write-Host ""

Write-Host "====================================" -ForegroundColor Green
Write-Host "Installing Frontend Dependencies..." -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Set-Location frontend
npm install
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Frontend installation failed" -ForegroundColor Red
    Set-Location ..
    Read-Host "Press Enter to exit"
    exit 1
}
Set-Location ..
Write-Host "Frontend dependencies installed successfully!" -ForegroundColor Green
Write-Host ""

Write-Host "====================================" -ForegroundColor Green
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Make sure MongoDB is running (localhost:27017)" -ForegroundColor White
Write-Host "   - Install from: https://www.mongodb.com/try/download/community" -ForegroundColor Cyan
Write-Host "   - Or use MongoDB Atlas: https://www.mongodb.com/cloud/atlas" -ForegroundColor Cyan
Write-Host ""
Write-Host "2. Update backend\.env file if needed" -ForegroundColor White
Write-Host ""
Write-Host "3. Run start-app.ps1 to launch the application" -ForegroundColor White
Write-Host ""
Read-Host "Press Enter to exit"
