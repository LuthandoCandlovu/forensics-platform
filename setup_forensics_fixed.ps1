Write-Host "Installing AI-Powered Digital Forensics Platform..." -ForegroundColor Cyan
if (-not (Get-Command python -ErrorAction SilentlyContinue)) { Write-Host "Python not found." -ForegroundColor Red; exit 1 }
pip install yara-python pandas scikit-learn email-validator python-magic volatility3 fastapi uvicorn
$rulesDir = "$env:USERPROFILE\yara_rules"
New-Item -ItemType Directory -Force -Path $rulesDir | Out-Null
Write-Host "Setup complete." -ForegroundColor Green
