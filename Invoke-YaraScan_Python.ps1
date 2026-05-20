param([Parameter(Mandatory)] [string]$TargetPath, [string]$RulesDir = "$env:USERPROFILE\yara_rules\rules-master")
$pythonScript = @"
import yara, os, sys, json, datetime
rules_path = r"$RulesDir"
if not os.path.exists(rules_path):
    print(f"Rules not found: {rules_path}")
    sys.exit(1)
rules = yara.compile(filepaths={f: os.path.join(rules_path, f) for f in os.listdir(rules_path) if f.endswith('.yar')})
target = r"$TargetPath"
results = []
if os.path.isfile(target):
    files = [target]
else:
    files = [os.path.join(root, f) for root,_,fs in os.walk(target) for f in fs]
for filepath in files:
    try:
        matches = rules.match(filepath)
        if matches:
            results.append({"file": filepath, "matches": [str(m) for m in matches], "timestamp": str(datetime.datetime.now())})
    except: pass
print(json.dumps(results))
"@
$pythonScript | Out-File -FilePath "$env:TEMP\yara_scan.py" -Encoding utf8
$jsonResult = python "$env:TEMP\yara_scan.py" | ConvertFrom-Json
if ($jsonResult.Count -gt 0) { $jsonResult | Export-Csv -Path "yara_scan_results.csv" -NoTypeInformation; Write-Host "Malware found in $($jsonResult.Count) files." -ForegroundColor Red }
else { Write-Host "No YARA matches." -ForegroundColor Green }
Remove-Item "$env:TEMP\yara_scan.py"
