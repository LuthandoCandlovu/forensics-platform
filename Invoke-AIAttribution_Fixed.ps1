param([int]$FailedLogins=0, [int]$NewServices=0, [int]$SuspiciousEmails=0, [int]$YaraMatches=0)
$features = @($FailedLogins, $NewServices, $SuspiciousEmails, $YaraMatches) | ConvertTo-Json -Compress
$aiResult = python ai_attribution.py "'$features'" | ConvertFrom-Json
$html = @"
<html><body><h1>AI Forensic Report</h1><p><strong>Threat:</strong> $($aiResult.threat)</p><p><strong>Confidence:</strong> $($aiResult.confidence)</p><p><strong>Recommendations:</strong> $($aiResult.recommendations -join ', ')</p></body></html>
"@
$html | Out-File -FilePath "AI_Report.html" -Encoding UTF8
Start-Process "AI_Report.html"
Write-Host "AI report generated: AI_Report.html" -ForegroundColor Magenta
