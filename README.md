# AI-Powered Digital Forensics Platform

AI-powered incident response platform that analyzes suspicious files, logs, emails, and memory using YARA, Windows event logs, and a machine learning attribution model.

## Features
- ✅ YARA‑based malware file scanning (recursive)
- ✅ Suspicious Windows event log detection (4625, 7045)
- ✅ Email phishing analysis (headers, links, attachments)
- ✅ Timeline reconstruction (file + process activity)
- ✅ ML threat attribution (RandomForest with placeholder model)
- ✅ HTML report with confidence score & recommendations

## Quick Start
1. Run .\setup_forensics_fixed.ps1 to install dependencies
2. Place suspicious files in suspicious_samples\
3. Place emails (.eml) in emails\
4. Execute .\Run-FullForensics_Fixed.ps1
5. View AI_Report.html

## Requirements
- Windows PowerShell 5.1+
- Python 3.8+

## Disclaimer
Use only on systems you own or have explicit permission to analyze.
