# Mana Prayanam - Setup with Portable Node.js
# No admin rights required!

Write-Host "====================================" -ForegroundColor Green
Write-Host "Mana Prayanam - No-Admin Setup" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Write-Host ""

$projectRoot = $PSScriptRoot
$nodePortablePath = "$projectRoot\nodejs-portable"
$nodeExe = "$nodePortablePath\node-v20.11.1-win-x64\node.exe"
$npmExe = "$nodePortablePath\node-v20.11.1-win-x64\npm.cmd"

# Check if portable node already exists
if (Test-Path $nodeExe) {
    Write-Host "✓ Portable Node.js found" -ForegroundColor Green
} else {
    Write-Host "Step 1: Downloading Portable Node.js..." -ForegroundColor Cyan
    Write-Host "(This doesn't require admin rights)" -ForegroundColor Gray
    
    try {
        $ProgressPreference = 'SilentlyContinue'
        $url = "https://nodejs.org/dist/v20.11.1/node-v20.11.1-win-x64.zip"
        $zipPath = "$env:TEMP\nodejs-portable.zip"
        
        Write-Host "Downloading from nodejs.org..." -ForegroundColor Gray
        Invoke-WebRequest -Uri $url -OutFile $zipPath -ErrorAction Stop
        Write-Host "✓ Download complete" -ForegroundColor Green
        
        Write-Host "Extracting files..." -ForegroundColor Gray
        if (-not (Test-Path $nodePortablePath)) {
            New-Item -ItemType Directory -Path $nodePortablePath -Force | Out-Null
        }
        Expand-Archive -Path $zipPath -DestinationPath $nodePortablePath -Force -ErrorAction Stop
        Write-Host "✓ Extraction complete" -ForegroundColor Green
        
        Remove-Item $zipPath -Force -ErrorAction SilentlyContinue
        Write-Host ""
    } catch {
        Write-Host "✗ Download failed: $_" -ForegroundColor Red
        Write-Host ""
        Write-Host "Try downloading manually:" -ForegroundColor Yellow
        Write-Host "https://nodejs.org/dist/v20.11.1/node-v20.11.1-win-x64.zip" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Extract to: $nodePortablePath" -ForegroundColor White
        Read-Host "Press Enter after manual download"
    }
}

# Verify Node.js
Write-Host "Step 2: Verifying Node.js..." -ForegroundColor Cyan
try {
    $nodeVersion = & $nodeExe --version 2>&1
    $npmVersion = & $npmExe --version 2>&1
    Write-Host "✓ Node.js: $nodeVersion" -ForegroundColor Green
    Write-Host "✓ npm: $npmVersion" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "✗ Node.js verification failed" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Install dependencies
Write-Host "Step 3: Installing Backend Dependencies..." -ForegroundColor Cyan
Set-Location "$projectRoot\backend"
Write-Host "Running: npm install (this may take a few minutes)" -ForegroundColor Gray
& $npmExe install --loglevel=error
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Backend installation failed" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host "✓ Backend ready" -ForegroundColor Green
Write-Host ""

Write-Host "Step 4: Installing Frontend Dependencies..." -ForegroundColor Cyan
Set-Location "$projectRoot\frontend"
Write-Host "Running: npm install (this may take a few minutes)" -ForegroundColor Gray
& $npmExe install --loglevel=error
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Frontend installation failed" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host "✓ Frontend ready" -ForegroundColor Green
Write-Host ""

# Save portable node path to file for start script
$configPath = "$projectRoot\node-config.txt"
Add-Content -Path $configPath -Value $nodeExe -Force
Add-Content -Path $configPath -Value $npmExe -Force

Write-Host "====================================" -ForegroundColor Green
Write-Host "✓ Setup Complete!" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next: Run start-app-portable.ps1 to launch" -ForegroundColor Cyan
Write-Host ""
Read-Host "Press Enter to exit"
