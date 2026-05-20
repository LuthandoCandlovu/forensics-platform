param([Parameter(Mandatory)] [string]$EmailPath)
if (-not (Test-Path $EmailPath)) { Write-Error "File not found"; return }
$content = Get-Content $EmailPath -Raw
$headers = @{}
$content -split "`r`n`r`n" | Select-Object -First 1 | ForEach-Object {
    $_ -split "`r`n" | ForEach-Object {
        if ($_ -match "^(?<key>[^:]+):\s*(?<value>.+)$") { $headers[$matches['key']] = $matches['value'] }
    }
}
$from = $headers['From']
$subject = $headers['Subject']
$links = [regex]::Matches($content, 'https?://[^\s"''<>]+') | ForEach-Object { $_.Value }
$hasAttachments = $content -match "Content-Disposition: attachment"
$report = [PSCustomObject]@{File=$EmailPath; From=$from; Subject=$subject; Suspicious=($from -match "paypal|secure|verify|account" -or $links.Count -gt 3); Links=$links -join "; "; HasAttachments=$hasAttachments}
$report | Export-Csv -Path "phishing_report.csv" -Append -NoTypeInformation
$report | Format-List
