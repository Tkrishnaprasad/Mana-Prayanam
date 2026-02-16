# Mana Prayanam - Start App with Portable Node.js

Write-Host "====================================" -ForegroundColor Green
Write-Host "Mana Prayanam - Starting Application" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Write-Host ""

$projectRoot = $PSScriptRoot
$nodeExe = "$projectRoot\nodejs-portable\node-v20.11.1-win-x64\node.exe"
$npmExe = "$projectRoot\nodejs-portable\node-v20.11.1-win-x64\npm.cmd"

# Verify portable node exists
if (-not (Test-Path $nodeExe)) {
    Write-Host "✗ Portable Node.js not found!" -ForegroundColor Red
    Write-Host "Please run setup-portable.ps1 first" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "Step 1: Starting Backend Server (port 5000)..." -ForegroundColor Cyan
$backendCmd = "cd '$projectRoot\backend'; & '$npmExe' start"
Start-Process powershell -ArgumentList "-NoExit", "-Command", $backendCmd

Write-Host "Waiting 5 seconds for backend to initialize..." -ForegroundColor Gray
Start-Sleep -Seconds 5

Write-Host "Step 2: Starting Frontend Server (port 3000)..." -ForegroundColor Cyan
$frontendCmd = "cd '$projectRoot\frontend'; & '$npmExe' start"
Start-Process powershell -ArgumentList "-NoExit", "-Command", $frontendCmd

Write-Host ""
Write-Host "====================================" -ForegroundColor Green
Write-Host "✓ Application Launching!" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Write-Host ""
Write-Host "Backend:  http://localhost:5000" -ForegroundColor Cyan
Write-Host "Frontend: http://localhost:3000" -ForegroundColor Cyan
Write-Host ""
Write-Host "Two server windows have been opened." -ForegroundColor Yellow
Write-Host "Keep them running while using the application." -ForegroundColor Yellow
Write-Host ""
Write-Host "Press any key to close this window..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
