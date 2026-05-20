param([int]$HoursBack = 24)
$startTime = (Get-Date).AddHours(-$HoursBack)
$suspicious = @()
$failed = Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4625; StartTime=$startTime} -ErrorAction SilentlyContinue
foreach ($e in $failed) { $suspicious += [PSCustomObject]@{Time=$e.TimeCreated; Type="Failed Login"; Detail=($e.Message -split "`n" | Select-String "Account Name" | Out-String).Trim()} }
$services = Get-WinEvent -FilterHashtable @{LogName='System'; ID=7045; StartTime=$startTime} -ErrorAction SilentlyContinue
foreach ($e in $services) { $suspicious += [PSCustomObject]@{Time=$e.TimeCreated; Type="New Service"; Detail=($e.Message -split "`n" | Select-String "Service Name" | Out-String).Trim()} }
$suspicious | Export-Csv "suspicious_logs.csv" -NoTypeInformation
$suspicious | Format-Table -AutoSize
Write-Host "Found $($suspicious.Count) suspicious events." -ForegroundColor Yellow
