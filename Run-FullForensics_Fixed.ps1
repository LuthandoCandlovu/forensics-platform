Write-Host "===== AI-Powered Digital Forensics =====" -ForegroundColor Cyan
if (Test-Path ".\suspicious_samples") { & ".\Invoke-YaraScan_Python.ps1" -TargetPath ".\suspicious_samples" } else { Write-Host "No suspicious_samples folder" -ForegroundColor DarkYellow }
& ".\Detect-SuspiciousLogs_Fixed.ps1" -HoursBack 48
if (Test-Path ".\emails") { Get-ChildItem ".\emails" -Filter *.eml | ForEach-Object { & ".\Analyze-Email_Fixed.ps1" -EmailPath $_.FullName } }
& ".\Build-Timeline_Fixed.ps1" -TargetDrive "C:\"
$failedCount = (Import-Csv "suspicious_logs.csv" -ErrorAction SilentlyContinue | Where-Object { $_.Type -eq "Failed Login" }).Count
$serviceCount = (Import-Csv "suspicious_logs.csv" -ErrorAction SilentlyContinue | Where-Object { $_.Type -eq "New Service" }).Count
$phishCount = (Import-Csv "phishing_report.csv" -ErrorAction SilentlyContinue | Where-Object { $_.Suspicious -eq "True" }).Count
$yaraCount = (Import-Csv "yara_scan_results.csv" -ErrorAction SilentlyContinue).Count
& ".\Invoke-AIAttribution_Fixed.ps1" -FailedLogins $failedCount -NewServices $serviceCount -SuspiciousEmails $phishCount -YaraMatches $yaraCount
Write-Host "Forensic analysis completed." -ForegroundColor Green
