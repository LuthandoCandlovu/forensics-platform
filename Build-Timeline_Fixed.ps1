param([string]$TargetDrive = "C:\")
$timeline = @()
$cutoff = (Get-Date).AddDays(-7)
Get-ChildItem $TargetDrive -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -gt $cutoff } | ForEach-Object { $timeline += [PSCustomObject]@{Timestamp=$_.LastWriteTime; Source="File"; Detail="$($_.FullName) modified"} }
$processes = Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4688; StartTime=$cutoff} -ErrorAction SilentlyContinue
foreach ($e in $processes) { $procName = ($e.Message -split "`n" | Select-String "New Process Name" | ForEach-Object { $_ -replace '.*:\s+', '' }); $timeline += [PSCustomObject]@{Timestamp=$e.TimeCreated; Source="Process"; Detail="Created: $procName"} }
$timeline | Sort-Object Timestamp | Export-Csv -Path "forensic_timeline.csv" -NoTypeInformation
Write-Host "Timeline with $($timeline.Count) entries saved." -ForegroundColor Green
