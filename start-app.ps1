# Mana Prayanam - Start Application
# PowerShell version

Write-Host "====================================" -ForegroundColor Green
Write-Host "Mana Prayanam - Starting Application" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Write-Host ""

Write-Host "Checking Node.js..." -ForegroundColor Yellow
try {
    $null = node --version 2>$null
} catch {
    Write-Host "ERROR: Node.js is not installed" -ForegroundColor Red
    Write-Host "Please run setup.ps1 first" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "Starting Backend Server on port 5000..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PWD\backend'; npm start"

Write-Host "Waiting 5 seconds for backend to initialize..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

Write-Host "Starting Frontend Server on port 3000..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PWD\frontend'; npm start"

Write-Host ""
Write-Host "====================================" -ForegroundColor Green
Write-Host "Application Starting!" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Write-Host ""
Write-Host "Backend:  http://localhost:5000" -ForegroundColor Cyan
Write-Host "Frontend: http://localhost:3000" -ForegroundColor Cyan
Write-Host ""
Write-Host "The browser will open automatically in a few seconds..." -ForegroundColor Yellow
Write-Host ""
Write-Host "Press any key to close this window" -ForegroundColor White
Write-Host "(Backend and Frontend will continue running in separate windows)" -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
